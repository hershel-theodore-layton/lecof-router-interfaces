/** lecof-router-interfaces is MIT licensed, see /LICENSE. */
namespace HTL\LecofInterfaces;

/**
 * The return value of `Filter->filter()` calls that did not abort.
 * The `T` is route target, f.e. a function reference or a Route object.
 * The `vec<ParsedVariable<mixed>>` is the list of variables in reverse order.
 * So `/users/4/friends/6` would have `vec[PV{6}, PV{4}]`.
 * Permitted operations on a `RouteResult`:
 *  - You may append zero or more `ParsedVariable` objects to the second element
 *      before returning the `RouteResult`.
 */
type RouteResult<+T> = (T, vec<ParsedVariable<mixed>>);
