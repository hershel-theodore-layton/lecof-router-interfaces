# lecof-router-interfaces

Interfaces for interop with [hershel-theodore-layton/lecof-router](https://github.com/hershel-theodore-layton/lecof-router)

`RequestInfo` exposes URL-decoded path segments. Split the URI path on raw `/`
first, then decode each segment once. Remove one leading slash; the empty path
and `/` have no segments. Keep other empty and trailing segments, and exclude
query and fragment text before splitting.

For a custom `RequestInfo`, this copyable constructor follows that contract
(`$path` is the URI path component):

```hack
private vec<string> $segments;

public function __construct(string $path)[] {
  $this->segments = \HH\Lib\Str\strip_prefix($path, '/')
    |> \HH\Lib\Str\split($$, '/')
    |> $$ === vec[''] ? vec[] : $$
    |> \HH\Lib\Vec\map($$, \urldecode<>);
}
```

| URI path | Segments |
| --- | --- |
| `/%30` | `vec['0']` |
| `/a%20b` or `/a+b` | `vec['a b']` |
| `/a/b` | `vec['a', 'b']` |
| `/a%2Fb` or `/a%2fb` | `vec['a/b']` |
| `/a%2F/b` | `vec['a/', 'b']` |
| `/a%252Fb` | `vec['a%2Fb']` |
| `/a//b` | `vec['a', '', 'b']` |
| `/a/b/` | `vec['a', 'b', '']` |

Return these same decoded segments from lookup/slicing methods. Never split a
segment again: a decoded slash belongs inside its segment. `literal('a/b', ...)`
can match `/a%2Fb`; nested literals `'a'`, `'b'` and `slashed_literal('a/b', ...)`
match `/a/b` instead. Variable parsers receive the decoded segment too, and
`getRawValue()` retains that supplied text. Do not URL-decode it again.

`getPathSegmentsAsString()` joins segments with `/` for convenience. Its result
cannot distinguish `vec['a/b']` from `vec['a', 'b']`; filters must preserve the
segment vector when matching. For the empty path and `/`, use `done()` directly;
slashed filters require a segment to be present.

Upstream URL normalization can change the path before this adapter sees it.
If an encoded slash must remain inside one segment, configure proxies to
preserve its encoded spelling until splitting.
