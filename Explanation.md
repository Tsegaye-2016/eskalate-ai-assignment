# Bug Fix Explanation

## What was the bug?

The `HttpClient` class did not correctly handle cases where `oauth2Token` was a plain object instead of an instance of `OAuth2Token`.

Inside the `request()` method, the Authorization header was only set if:

```ts
this.oauth2Token instanceof OAuth2Token
```

If `oauth2Token` was a plain object (e.g. `{}`), it was truthy but not an instance of `OAuth2Token`.  
As a result, the Authorization header was never set, even when `api: true` was passed.

---

## Why did it happen?

The code relied entirely on `instanceof OAuth2Token` to determine whether the token was valid.

A plain object is not an instance of `OAuth2Token`, so:

- `refreshOAuth2()` was not always triggered correctly
- The `Authorization` header was not added
- Requests using `api: true` could silently fail to authenticate

This created inconsistent behavior depending on how `oauth2Token` was assigned.

---

## How was it reproduced?

A test was added that sets:

```ts
client.oauth2Token = {};
```

Then performs:

```ts
client.request("GET", "/me", { api: true });
```

The test expected:

```ts
Authorization: "Bearer fresh-token"
```

Before the fix, this test failed because the header was undefined.

---

## What is the fix?

The fix ensures that `refreshOAuth2()` is called when:

- No token exists
- The token is expired
- The token is not a valid `OAuth2Token` instance

After refreshing, the token becomes a valid `OAuth2Token`, and the Authorization header is correctly set.

The change was minimal and limited only to the conditional logic in `request()`.

---

## Why does this fix work?

It guarantees that before setting the Authorization header:

1. The token exists
2. The token is valid
3. The token is a proper `OAuth2Token` instance

Therefore, all `api: true` requests consistently include a valid `Bearer` token.

---

## Edge Case Not Covered

If `oauth2Token` is a non-null object that mimics an `OAuth2Token` structure but contains invalid internal values, the current tests do not verify how the client behaves.

This could be improved with additional validation tests.
