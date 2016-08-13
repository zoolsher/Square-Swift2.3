// The MIT License (MIT) - Copyright (c) 2016 Carlos Vidal
//
// THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
// IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
// FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
// AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
// LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
// OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
// SOFTWARE.

#if os(iOS) || os(tvOS)
import UIKit
#else
import AppKit
#endif

/**
    Typealias of a closure with no parameters and `Bool`
    as returning type.
 
    This type of closure is used to evaluate whether an
    `Attribute` should be applied or not.
 */
public typealias Condition = () -> Bool

/**
    This class is the abstraction of `NSLayoutConstraint` 
    objects used by **EasyPeasy** to create and update
    `UIView` constraints
 */
public class Attribute {
    
    /// This property aggregates the `NSLayoutRelation`,
    /// the constant and the multiplier of a layout 
    /// constraint
    public internal(set) var constant: Constant
    
    /// Priority level of the constraint
    public internal(set) var priority: Priority
    
    /// Condition to evaluate in order to apply
    /// (or not) the constraint
    public internal(set) var condition: Condition?
    
    /// Target `UIView` of the constraint
    public internal(set) weak var createItem: Item?
    
    /// `Attribute` applied to the view
    public var createAttribute: ReferenceAttribute {
        debugPrint("This point shouldn't have been reached")
        return .Width
    }
    
    /// Reference `UIView` of the constraint
    public internal(set) weak var referenceItem: AnyObject?
    
    /// Referencce `Attribute` of the constraint
    public internal(set) var referenceAttribute: ReferenceAttribute?
    
    /// Equivalent `NSLayoutConstraint`. It's `nil` unless the method
    /// `createConstraints(for item:_)` is called
    internal(set) var layoutConstraint: NSLayoutConstraint?
    
    /// Element identifying the node this attribute will be 
    /// stored in
    internal lazy var signature: String = {
        return String.easy_signature(for: self)
    }()
    
    /**
        Initializer which creates an `Attribute` instance
        with `constant = 0.0`, `multiplier = 1.0` and
        `relatedBy = .Equal`
        - returns: the `Attribute` instance created
     */
    public init() {
        self.constant = Constant(0.0)
        self.priority = .HighPriority
    }
    
    /**
        Initializer which creates an `Attribute` instance
        with `constant = value`, `multiplier = 1.0` and
        `relatedBy = .Equal`
        - parameter value: `constant` of the constraint
        - returns: the `Attribute` instance created
     */
    public init(_ value: CGFloat) {
        self.constant = Constant(value)
        self.priority = .HighPriority
    }
    
    /**
        Initializer which creates an `Attribute` instance
        with the `constant`, `multiplier` and `relatedBy`
        specified by the `Constant` struct
        - parameter constant: `Constant` struct aggregating
        `constant`, `multiplier` and `relatedBy` properties
        - returns: the `Attribute` instance created
     */
    public init(_ constant: Constant) {
        self.constant = constant
        self.priority = .HighPriority
    }
    
    // MARK: Public methods
    
    /**
        Sets the `priority` of the constraint
        - parameter priority: `Priority` enum specifying the
        priority of the constraint
        - returns: the `Attribute` instance
     */
    public func with(priority: Priority) -> Self {
        self.priority = priority
        return self
    }
    
    /**
        Sets the `when` closure of the `Attribute`
        - parameter closure: `Closure` to be called before
        installing a constraint
        - returns: the `Attribute` instance
     */
    public func when(closure: Condition?) -> Self {
        self.condition = closure
        return self
    }
    
    // MARK: Internal methods (acting as protected)
    
    /** 
        This method creates the `NSLayoutConstraints` equivalent to the
        current `Attribute`. The resulting constraint is held by the 
        property `layoutConstraint`
        - parameter view: `UIView` in which the generated
        `NSLayoutConstraint` will be added
        - returns an `Array` of `NSLayoutConstraint` objects that will
        be installed on the `UIView` passed as parameter
     */
    internal func createConstraints(for item: Item) -> [NSLayoutConstraint] {
        guard let _ = item.owningView else {
            debugPrint("EasyPeasy Attribute cannot be applied to item \(item) as its superview/owningView is nil")
            return []
        }
        
        // Reference to the target view
        self.createItem = item
        
        // Build layout constraint
        let constantFactor: CGFloat = self.createAttribute.shouldInvertConstant ? -1 : 1
        let layoutConstraint = NSLayoutConstraint(
            item: item,
            attribute: self.createAttribute.layoutAttribute,
            relatedBy: self.constant.layoutRelation(),
            toItem: self.referenceItem,
            attribute: self.referenceAttributeHelper().layoutAttribute,
            multiplier: self.constant.layoutMultiplier(),
            constant: (self.constant.layoutValue() * constantFactor)
        )
        
        // Set priority
        layoutConstraint.priority = self.priority.layoutPriority()
        
        // Reference resulting constraint
        self.layoutConstraint = layoutConstraint
        
        // Return the constraint
        return [layoutConstraint]
    }
    
    /**
        Determines whether the `Attribute` must be installed or not
        depending on the `Condition` closure
        - return boolean determining if the `Attribute` has to be
        applied
     */
    internal func shouldInstall() -> Bool {
        return self.condition?() ?? true
    }

    /**
        Determines which `ReferenceAttribute` must be taken as reference
        attribute for the actual Attribute class. Usually is the opposite
        of the one that is going to be installed
        - returns `ReferenceAttribute` to install
     */
    internal func referenceAttributeHelper() -> ReferenceAttribute {
        // If already set return
        if let attribute = self.referenceAttribute {
            return attribute
        }
        
        // If reference view is the superview then return same attribute
        // as `createAttribute`
        if let referenceItem = self.referenceItem where referenceItem === self.createItem?.owningView {
            return self.createAttribute
        }
        
        // Otherwise return the opposite of `createAttribute`
        return self.createAttribute.opposite
    }
    
}

/**
    Methods applicable to an `Array` of `Attributes`. The modifiers
    will affect to each one of the `Attributes` within the `Array`
    overriding the values individually set.
 */
public extension Array where Element: Attribute {
   
    // MARK: Public methods
    
    /**
        Sets the `priority` of each constraint within the current `Array`
        of `Attributes`. If the priority was already set this method
        overrides it
        - parameter priority: `Priority` enum specifying the priority of 
        the constraint
        - returns: the `Array` of `Attributes`
     */
    public func with(priority: Priority) -> [Attribute] {
        for attribute in self {
            attribute.priority = priority
        }
        return self
    }
    
    /**
        Sets the `when` closure of each one of `Attributes` within the
        current `Array`. If the condition was already set this method
        overrides it
        - parameter closure: `Closure` to be called before installing
        each constraint
        - returns: the `Array` of `Attributes`
     */
    public func when(closure: Condition?) -> [Attribute] {
        for attribute in self {
            attribute.condition = closure
        }
        return self
    }
    
}
