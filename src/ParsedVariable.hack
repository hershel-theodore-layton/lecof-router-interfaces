/** lecof-router-interfaces is MIT licensed, see /LICENSE. */
namespace HTL\LecofRouterInterfaces;

/**
 * A manner of returning information from `->filter()` calls.
 * Some endpoints use one or more path segments as variables.
 * @example `/users/4/friends/6` would access the friend list of user with id 4
 * and return the sixth page of friends.
 * The `4` and `6` would be wrapped in a `ParsedVariable<int>` or a fancy
 * `ParsedVariable<ID<User>>`.
 */
interface ParsedVariable<+T> {
  public function getName(): string;
  /**
   * The string value from which the variable is parsed.
   * So when parsing the user id from `/users/4`, this is `string(1) "4"`.
   */
  public function getRawValue(): string;
  public function getValue(): T;
}
