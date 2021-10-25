/** lecof-router-interfaces is MIT licensed, see /LICENSE. */
namespace HTL\LecofInterfaces;

/**
 * The instructions for parsing information from a path segment.
 */
interface VariableParser<+T> {
  /**
   * Returns true iff `->parse()` would return a value (not throw) given $raw.
   */
  public function canParse(string $raw): bool;
  /**
   * If $raw can not be parsed, an `InvalidArgumentException` must be thrown.
   * The parsed result must be wrapped in a `ParsedVariable` including $raw.
   * Most sensible implementations of `ParsedVariable` will also require a
   * name to be supplied.
   */
  public function parse(string $raw): ParsedVariable<T>;
}
