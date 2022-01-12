/** lecof-router-interfaces is MIT licensed, see /LICENSE. */
namespace HTL\LecofInterfaces;

/**
 * The element of composition of Lecof.
 * Filters are usually nested in a tree.
 * Implementing this interface allows your class to be nested inside of a tree.
 * @see hershel-theodore-layton/lecof-router for examples.
 */
interface Filter<+T> {
  /**
   * When `->filter()` is called on the top-level Filter, a fresh RequestInfo
   * object and an integer 0 must be provided. A filter may inspect one or
   * more path segments or other attributes of the request. The Filter then
   * decides whether to abort this subtree. If this subtree is aborted, null
   * must be returned or an exception may be thrown. If this subtree is not
   * aborted, and the Filter needs to call `->filter()` on an inner / nested
   * Filter, the following conditions must be met:
   *
   * - If a path segment is consumed, the $index passed to `->filter()` must
   *     be incremented by the amount of path segments consumed.
   * - If the inner / nested `->filter()` call returns null, the current call
   *     must return null or throw an exception.
   * - If the inner / nested `->filter()` call returns a nonnull value, the
   *    current call may not return null. See `RouteResult` for permitted
   *    operations on the return value of `->filter()`.
   */
  public function filter(
    RequestInfo $request_info,
    int $index,
  ): ?RouteResult<T>;
}
