# regexbr.lua 说明
这个工具是用来匹配正则 + 嵌套括号的。

# Demo
### Pattern
`Log%.d%d*%(`

### Input:
```
print("hello,world")
Log.d2("aaa", math.random(100), tostring({1,2,3}))

    print("hello,world 2")
    Log.d2("aaa", math.random(100), tostring({1,2,3}))

    Log.d2("aaa", 
        math.random(100), tostring({1,2,3}))

    local function line11()
        print("line11")
    end

    Log.d2("aaa", 
        math.random(100), 
        tostring({1,2,3})
    )

    print("hello");Log.d2("aaa", math.random(100), tostring({1,2,3}));print("world")

    print("hello");Log.d2("aaa", 
        math.random(100), 
        tostring({1,2,3}));print("world") 

    print("hello");Log.d2("aaa", 
        math.random(100), 
        tostring({1,2,3})
        );print("world") 

Log.d3("lasdkfj")
Log.dpack("asldfkj")
Log.dump("sldkfj")
Log.d("sdlfjk")
Log.traceback("asdfasdf")
```

### Output:
```
print("hello,world")


    print("hello,world 2")
    

    

    local function line11()
        print("line11")
    end

    

    print("hello");;print("world")

    print("hello");;print("world") 

    print("hello");;print("world") 


Log.dpack("asldfkj")
Log.dump("sldkfj")

Log.traceback("asdfasdf")
```

# 这个工具有什么用呢
可以用来批量删除 Lua 源文件中的调试 Log，可以在发布之前做一次这个操作，可以使发布版本性能更好。


