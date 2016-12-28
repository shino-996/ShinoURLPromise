研究了一下swift的函数式编程以及一些链式调用的原理，试着自己写了一个链式调用的封装。

# 进度

## 2016-12-28

大体思路已完成，可以运行，并封装了URLSession

---

# 食用方法

代码主体为`./ShinoURLPromise/Async.swift`，里面顺便封装了可链式调用的`URLSession`中的`func dataTask(with url: URL) -> Async<Data?>`方法。

视图中`viewDidLoad`方法中包含示例代码。