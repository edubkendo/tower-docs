# Deploying to Nodejitsu

Delete design.io in devDependencies as it will cause an issue. This issue has been flagged by nodejitsu. <br>

Put this at the top of config/application.coffee: <br>
if process.env.NODE_ENV == 'production' <br>
  Tower.Application::watch = -> <br>
  Tower.env = 'production' <br>
