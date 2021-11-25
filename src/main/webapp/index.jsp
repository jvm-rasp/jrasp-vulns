<%@ page contentType="text/html; charset=UTF-8" %>
<!DOCTYPE html>
<html>

<head>
  <meta charset="utf-8">
  <meta name="viewport" content="width=device-width, initial-scale=1.0">
  <title>JRASP 官方测试用例集合</title>
  <link rel="stylesheet" href="assets/css/bootstrap.min.css" media="screen">
  <script src="assets/js/angular.min.js" charset="utf-8"></script>
  <style media="screen">
    thead tr td {
      background-color: #f1f1f1
    }
  </style>
</head>

<body>
<div ng-app="myapp" ng-controller="main">
  <div class="container" id="main">
    <div class="row">
      <div class="col-xs-12 col-sm-8 col-sm-offset-2">
        <h3 class="text-center">JRASP 官方测试用例集合</h3>
        <br/>
        <table class="table table-striped">
          <thead>
          <tr>
            <td>测试用例</td>
            <td>用例路径</td>
          </tr>
          </thead>
          <tbody>
          <tr ng-repeat="a in testcases">
            <td>{{a.name}}</td>
            <td><a target="_blank" ng-href="{{a.path}}">{{a.path}}</a></td>
          </tr>
          </tbody>
        </table>
      </div>
    </div>
  </div>
</div>

<script type="text/javascript">
    var app = angular.module('myapp', []);

    app.controller('main', ['$scope', '$http',
        function ($scope, $http) {

            $scope.testcases = [
                {"name": "001 - 命令执行后门 - 无回显", "path": 'command-1.jsp'},
                {"name": "002 - 命令执行后门 - 有回显", "path": 'command-2.jsp'},
                {"name": "003 - 任意文件写入后门", "path": 'file-write.jsp'},
                {"name": "004 - 任意文件读取后门", "path": 'file-read.jsp'},
                {"name": "005 - 任意目录遍历后门", "path": 'file-list.jsp'},
                {"name": "006 - 任意文件删除后门", "path": 'file-delete.jsp'},
                {"name": "007 - 通过XXE读取系统文件", "path": 'xxe.jsp'},
            ]
        }
    ]);
</script>

</body>
<!-- design, implemented by c0debreak -->
</html>
