### sinatra

> 使用em_mysql2
 ab -c 50 -n 100 http://127.0.0.1:9393/users/show

    Concurrency Level:      50
    Time taken for tests:   66.995 seconds
    Complete requests:      100
    Failed requests:        0
    Total transferred:      91100 bytes
    HTML transferred:       19200 bytes
    Requests per second:    1.49 [#/sec] (mean)
    Time per request:       33497.480 [ms] (mean)
    Time per request:       669.950 [ms] (mean, across all concurrent requests)
    Transfer rate:          1.33 [Kbytes/sec] received

    Connection Times (ms)
                  min  mean[+/-sd] median   max
    Connect:        0    1   0.5      1       2
    Processing: 21198 29588 5917.1  32589   40907
    Waiting:    14177 23605 6021.5  26086   34404
    Total:      21200 29589 5916.9  32589   40907

> 使用mysql2

      Concurrency Level:      50
      Time taken for tests:   69.279 seconds
      Complete requests:      100
      Failed requests:        0
      Total transferred:      91100 bytes
      HTML transferred:       19200 bytes
      Requests per second:    1.44 [#/sec] (mean)
      Time per request:       34639.734 [ms] (mean)
      Time per request:       692.795 [ms] (mean, across all concurrent requests)
      Transfer rate:          1.28 [Kbytes/sec] received

      Connection Times (ms)
                    min  mean[+/-sd] median   max
      Connect:        0    0   0.4      1       1
      Processing: 15100 30486 7200.8  33412   41913
      Waiting:     8458 24404 7248.5  26813   35474
      Total:      15101 30486 7200.6  33412   41913 


ab -c 100 -n 500 -s 60 http://127.0.0.1:9393/users/show        （均挂）


ab -c 100 -n 500 -s 100 http://127.0.0.1:9393/users/show

> 使用em_mysql2

    Concurrency Level:      100
    Time taken for tests:   335.106 seconds
    Complete requests:      500
    Failed requests:        0
    Total transferred:      455500 bytes
    HTML transferred:       96000 bytes
    Requests per second:    1.49 [#/sec] (mean)
    Time per request:       67021.297 [ms] (mean)
    Time per request:       670.213 [ms] (mean, across all concurrent requests)
    Transfer rate:          1.33 [Kbytes/sec] received

    Connection Times (ms)
                  min  mean[+/-sd] median   max
    Connect:        0    1   0.8      0       3
    Processing: 33003 62247 8504.9  66259   74811
    Waiting:    10225 54769 11396.3  59614   68293
    Total:      33003 62248 8504.6  66259   74813
    WARNING: The median and mean for the initial connection time are not within a normal deviation
            These results are probably not that reliable.

> 使用mysql2

    Concurrency Level:      100
    Time taken for tests:   373.798 seconds
    Complete requests:      500
    Failed requests:        0
    Total transferred:      455500 bytes
    HTML transferred:       96000 bytes
    Requests per second:    1.34 [#/sec] (mean)
    Time per request:       74759.657 [ms] (mean)
    Time per request:       747.597 [ms] (mean, across all concurrent requests)
    Transfer rate:          1.19 [Kbytes/sec] received

    Connection Times (ms)
                  min  mean[+/-sd] median   max
    Connect:        0    0   0.7      0       3
    Processing: 29060 69516 12073.7  73400   81731
    Waiting:    19194 60524 15179.8  66476   74421
    Total:      29060 69516 12073.5  73400   81731

### 结论
    
    请求数量    并发量    使用em_mysql2           使用mysql2
    100        50       33497.480（最大延时30s） 34639.734(最大延时60, 30s已挂)
    500        100      挂(最大延时60s）         挂(最大延时60s）
    500        100      67021.297(最大延时100s） 74759.657(最大延时100s）
             

