// Closure is basically an anonymous function
// Closure can be passed as parameters and returned as values

// TASK: CREATE A REDUCER FUNCTION USING CLOSURES
func reduce(_ values:[Int], using closure: (Int, Int)->Int)->Int{
    var current = values[0];
    for value in values[1...] {
        current = closure(current,value);
    }
    return current;
}

let finalValue = reduce([1,2,34,10], using: {
    (a:Int, b:Int) -> Int in
    return a+b;
});

print("finalValue=\(finalValue)");

// TASK: CREATE A MAP FUNCTION (SIMILAR TO JS)
func _map(_ list: [Int], transform: (Int)->Int)->[Int]{
    var newList:[Int]=[];
    for value in list {
        let newValue = transform(value);
        newList.append(newValue);
    }
    return newList;
}

let newValues = _map([1,2,3,4], transform: {
    (a:Int) in
    return a*a;
})
print("newValues:\(newValues)")

// TASK: CREATE A FILTER FUNCTION (SIMILAR TO JS)
func _filter(_ list: [Int], filterCondition: (Int)->Bool)->[Int]{
    var filteredList:[Int]=[];
    for value in list {
        if filterCondition(value) {
            filteredList.append(value)
        }
    }
    return filteredList;
}
let onlyAdults = _filter([24,8,10,23,39,1,88], filterCondition: {
    (age:Int)->Bool in
    return age >= 18;
})
print("onlyAdults=\(onlyAdults)")
