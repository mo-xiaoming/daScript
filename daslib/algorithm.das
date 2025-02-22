options indenting = 4
options no_unused_block_arguments = false
options no_unused_function_arguments = false

module algorithm shared public

require daslib/array_boost
require daslib/contracts

def unique ( var a:array<auto(TT)> )
    //! Returns array of the elements of a with duplicates removed.
    var pidx = -1
    var b : array<TT-const-&>
    for e,eidx in a,range(length(a))
        if pidx==-1 || a[pidx]!=e
            pidx = eidx
            b |> push_clone(e)
    return <- b

def sort_unique ( var a : array<auto(TT)> )
    //! Returns array of the elements of a, sorted and with duplicates removed.
    //! The elements of a are sorted in ascending order.
    //! The resulted array has only unqiue elements.
    if empty(a)
        return
    sort(a)
    var b <- unique(a)
    delete a
    a <- b

def reverse ( var a:array<auto> )
    //! Returns array of the elements of a in reverse order.
    let l = length(a)
    let half = l/2
    let lm1 = l-1
    for i in range(half)
        swap(a[i], a[lm1-i])

def combine ( a,b:array<auto(TT)> )
    //! Returns array of the elements of a and then b.
    var c : array<TT>
    reserve(c, length(a) + length(b))
    for t in a
        c |> push(t)
    for t in b
        c |> push(t)
    return <- c

def lower_bound ( a:array<auto(TT)>; f,l:int; val : TT const-& )
    //! Returns an iterator pointing to the first element in the range [first, last) that is not less than (i.e. greater or equal to) value, or last if no such element is found.
    assert(f>=0 && f<=l,"lower bound first out of range")
    assert(l>=f && l<=length(a),"lower bound last out of range")
    var count = l - f
    var first = f
    while count > 0
        let step = count / 2
        let it = first + step
        if a[it] < val
            first += step + 1
            count -= step + 1
        else
            count = step
    return first

def lower_bound ( a:array<auto(TT)>; val : TT const-& )
    return lower_bound(a,0,length(a),val)

def lower_bound ( a:array<auto(TT)>; f, l : int; value:TT const-&; less : block<(a, b:TT const-&):bool> )
    assert(f>=0 && f<=l,"lower bound first out of range")
    assert(l>=f && l<=length(a),"lower bound last out of range")
    var count = l - f
    var first = f
    while count > 0
        let step = count / 2
        let it = first + step
        if invoke(less,a[it],value)
            first += step + 1
            count -= step + 1
        else
            count = step
    return first

def lower_bound ( a:array<auto(TT)>; value:TT const-&; less : block<(a, b:TT const-&):bool> )
    return lower_bound(a, 0, length(a), value, less )

def binary_search ( a:array<auto(TT)>; val : TT const-& )
    let first = lower_bound(a, val)
    return (first!=length(a)) && (!(val<a[first]))

def binary_search ( a:array<auto(TT)>; f, last : int; val : TT const-& )
    //! Returns true if an val appears within the range [f, last).
    //! Array a must be sorted.
    let first = lower_bound(a, f, last, val)
    return (first!=last) && (!(val<a[first]))

def binary_search ( a:array<auto(TT)>; val : TT const-&; less : block<(a, b:TT const-&):bool> )
    let first = lower_bound(a, val, less)
    let last = length(a)
    return (first!=last) && (!invoke(less,val,a[first]))

def binary_search ( a:array<auto(TT)>; f, last : int; val : TT const-&; less : block<(a, b:TT const-&):bool> )
    let first = lower_bound(a, f, last, val, less)
    return (first!=last) && (!invoke(less,val,a[first]))

// now for all the other types

[expect_any_array(a)]
def reverse ( var a )
    unsafe
        reverse(temp_array(a))

[expect_any_array(a)]
def combine ( a,b )
    unsafe
        return combine(temp_array(a),temp_array(b))

[expect_any_array(a)]
def lower_bound ( a; f,l:int; val )
    static_if typeinfo(stripped_typename a[0]) != typeinfo(stripped_typename val)
        concept_assert(false, "value type {typeinfo(stripped_typename val)} should be the same as array {typeinfo(stripped_typename a)} element type {typeinfo(stripped_typename a[0])}")
        return -1
    else
        unsafe
            return lower_bound(temp_array(a), f,l, val)

[expect_any_array(a)]
def lower_bound ( a; val )
    static_if typeinfo(stripped_typename a[0]) != typeinfo(stripped_typename val)
        concept_assert(false, "value type {typeinfo(stripped_typename val)} should be the same as array {typeinfo(stripped_typename a)} element type {typeinfo(stripped_typename a[0])}")
        return -1
    else
        unsafe
            return lower_bound(temp_array(a), val)

[expect_any_array(a)]
def lower_bound ( a; f, l : int; val:auto(TT); less : block<(a, b:TT const-&):bool> )
    static_if typeinfo(stripped_typename a[0]) != typeinfo(stripped_typename val)
        concept_assert(false, "value type {typeinfo(stripped_typename val)} should be the same as array {typeinfo(stripped_typename a)} element type {typeinfo(stripped_typename a[0])}")
        return -1
    else
        unsafe
            return lower_bound(temp_array(a), f, l, value, less)

[expect_any_array(a)]
def lower_bound ( a; val:auto(TT); less : block<(a, b:TT const-&):bool> )
    static_if typeinfo(stripped_typename a[0]) != typeinfo(stripped_typename val)
        concept_assert(false, "value type {typeinfo(stripped_typename val)} should be the same as array {typeinfo(stripped_typename a)} element type {typeinfo(stripped_typename a[0])}")
        return -1
    else
        unsafe
            return lower_bound(temp_array(a), val, less)

[expect_any_array(a)]
def binary_search ( a; val )
    static_if typeinfo(stripped_typename a[0]) != typeinfo(stripped_typename val)
        concept_assert(false, "value type {typeinfo(stripped_typename val)} should be the same as array {typeinfo(stripped_typename a)} element type {typeinfo(stripped_typename a[0])}")
        return -1
    else
        unsafe
            return binary_search(temp_array(a), val)

[expect_any_array(a)]
def binary_search ( a; f, last : int; val )
    static_if typeinfo(stripped_typename a[0]) != typeinfo(stripped_typename val)
        concept_assert(false, "value type {typeinfo(stripped_typename val)} should be the same as array {typeinfo(stripped_typename a)} element type {typeinfo(stripped_typename a[0])}")
        return -1
    else
        unsafe
            return binary_search(temp_array(a), f, last, val)

[expect_any_array(a)]
def binary_search ( a; val : auto(TT); less : block<(a, b:TT const-&):bool> )
    static_if typeinfo(stripped_typename a[0]) != typeinfo(stripped_typename val)
        concept_assert(false, "value type {typeinfo(stripped_typename val)} should be the same as array {typeinfo(stripped_typename a)} element type {typeinfo(stripped_typename a[0])}")
        return -1
    else
        unsafe
            return binary_search(temp_array(a), val, less)

[expect_any_array(a)]
def binary_search ( a; f, last : int; val : auto(TT); less : block<(a, b:TT const-&):bool> )
    static_if typeinfo(stripped_typename a[0]) != typeinfo(stripped_typename val)
        concept_assert(false, "value type {typeinfo(stripped_typename val)} should be the same as array {typeinfo(stripped_typename a)} element type {typeinfo(stripped_typename a[0])}")
        return -1
    else
        unsafe
            return binary_search(temp_array(a), f, last, val, less)
