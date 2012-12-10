# Notes from the book.

## Chapter 1

### Method Extract

* Look in the fragment (bit we are extracting) for any variables that are local in scope
to the method we are looking at
* Any nonmodified variable I can pass in as a parameter.
* Modified variables need more care. If there is only one, I can return
it. The temp is initialized to 0 each time around the loop and is not altered until
the case gets to it. So I can just assign the result.
*In most cases a method should be on the object whose data it uses e.g. amount for uses data from Rental not Customer.
* If a variable is set and then not modified like this_amount, then you can use Replace Temp With Query to eliminate it. This has performance implications because the method is now being called twice, but the author says first go for clarity, and then look at performance.
* Replace temp with query is good because queries are available to all the methods in the class.

#### New Terms:
* _Move Method_ - When you take a method in an inappropriate model, and move it to a new better home.
* _Replace Temp With Query_ - When you eliminate a temporary variable by using the thing that sets it initially in the places it was called/referenced.
* _Collection Closure_ - Some languages support closures and collections, they can be used to eliminate each loops Object.elements.each {|e|} is the preferred single line syntax of Object.elements.each do |e| //block end. In rails Object.elements.collect, inject, select...etc are examples of Collection closures.




