# Logging

```
[2011-10-31 20:30:58] INFO  WEBrick 1.3.1
[2011-10-31 20:30:58] INFO  ruby 1.9.2 (2010-08-18) [x86_64-darwin10.7.0]
[2011-10-31 20:30:58] INFO  WEBrick::HTTPServer#start: pid=16978 port=3000

Started GET "/" for 127.0.0.1 at 2011-10-31 20:31:44 -0700
  Processing by PostsController#index as HTML
  Parameters: {"q"=>"value"}
Rendered projects/_item.haml (97.3ms)
Rendered projects/index.haml within layouts/application (446.0ms)
Compiled application.css  (865ms)  (pid 16978)
Rendered shared/_meta.haml (1510.2ms)
Rendered shared/_navigation.haml (9.2ms)
Rendered shared/_footer.haml (57.1ms)
Completed 200 OK in 2573ms (Views: 2266.3ms)


Started GET "/assets/jqmath.css?body=1" for 127.0.0.1 at 2011-10-31 20:31:47 -0700
Served asset /jqmath.css - 200 OK (21ms)
```
