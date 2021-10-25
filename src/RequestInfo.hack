/** lecof-router-interfaces is MIT licensed, see /LICENSE. */
namespace HTL\LecofRouterInterfaces;

/**
 * Contains the path for routing.
 * May contain many other aspects of the request.
 */
interface RequestInfo {
  /**
   * Extension mechanism for fetching non-path aspects of the request.
   * This library did not want to supply an opinionated enum for HttpMethod or
   * force everyone to use a string instead.
   * You may use your own enum and use `->getByType<YourCode\HttpMethod>()`.
   * You may also have a use for routing based on the value of a cookie.
   * You may use a `beta=1` cookie and use `->getByType<YourCode\IsBetaUser>()`.
   * In short, I don't know what you need to route, but your implementation can
   * extend the information provided to the Filter here.
   */
  public function getByType<reify T>(): ?T;
  /**
   * Returns the value of `->getByType<T>()` if nonnull, otherwise an exception
   * is thrown. No requirement is placed on the type of the exception.
   * You may use this for "required" extensions.
   */
  public function getByTypex<reify T>(): T;

  /**
   * Returns the length of the path in segments.
   * `https://example.com` and `https://example.com/` have a length of 0.
   * `https://example.com/about-us` has a length of 1.
   * `https://example.com/about-us/` has a length of 2.
   * `https://example.com/a//b` has a length of 3.
   */
  public function getPathLength(): int;
  /**
   * Returns the text of the segment at the provided index.
   * `https://example.com/a/b` returns `a` for 0, `b` for 1, and null for all
   * other positive integers.
   * `https://example.com/a//b/` returns an empty string for 1 and 3.
   * The behavior for negative integers is not defined.
   */
  public function getPathSegment(int $index): ?string;
  /**
   * Returns all path segments with the same semantics as `Vec\slice()`.
   */
  public function getPathSegments(
    int $start = 0,
    ?int $length = null,
  ): vec<string>;
  /**
   * Returns all path segments returned by `->getPathSegments()` joined by `/`.
   */
  public function getPathSegmentsAsString(
    int $start = 0,
    ?int $length = null,
  ): string;
  /**
   * Returns the value returned by `->getPathSegment()`. If the value is null
   * an unspecified exception type is thrown.
   */
  public function getPathSegmentx(int $index): string;
  /**
   * Returns true iff `->getPathSegment()` would return nonnull given $index.
   */
  public function hasPathSegment(int $index): bool;
  /**
   * Returns true iff `->getPathSegment()` would return null given $index.
   */
  public function pathHasBeenExhausted(int $index): bool;
}
