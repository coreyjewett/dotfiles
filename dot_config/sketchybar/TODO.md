## Notify on gitlab todos count

```
glab api /todos | jq length
```

## Notify on Slack messages (using websockets)

- <https://api.slack.com/apis/socket-mode#sdks>
- <https://github.com/kernelsauce/turbo/tree/master> (needs LuaJIT2)
- OR <https://github.com/lipp/lua-websockets/blob/master/API.md>
