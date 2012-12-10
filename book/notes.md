#Notes from the book.

##Chapter 1

###Method Extract

* Look in the fragment (bit we are extracting) for any variables that are local in scope
to the method we are looking at
* Any nonmodified variable I can pass in as a parameter.
* Modified variables need more care. If there is only one, I can return
it. The temp is initialized to 0 each time around the loop and is not altered until
the case gets to it. So I can just assign the result.
*In most cases a method should be on the object whose data it uses e.g. amount for uses data from Rental not Customer.






