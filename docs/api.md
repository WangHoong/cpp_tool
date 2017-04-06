
# Introduce 说明


## intro规范
 ■用户登陆授权访问（基于http协议头验证）

 格式样例：--header "Authorization: Token token=O8ATFEm4KxFJmT0jEg5FLYA=="

 ■ 统一返回数据说明

 1: 所有时间格式为: DTS(数字时间戳)

 2: 空字符: ""

 3: 所有是否的布尔值返回: 0为false,1为true

 4: 空数组为: []


■ 所有返回状态为http协议状态

　如果请求失败，返回包含如下内容的JSON字符串：

 {
     "errcode":     <HttpCode  int>,
     "errmsg":   "<ErrMsg    string>"
 }

 ■ 统一分页参数（包含在meta标签中）

 *分页请求参数

  page: 页面号,per_page: 每页返回记录

 *分页返回

 包含在meta标签中

 {"meta":
   {"current_page":#当前页面,
    "next_page":null,
    "prev_page":null,
    "total_pages":#总页数,
    "total_count":#共计多少条}
 }


# Part1 用户管理

## 1、用户登录接口

### HTTP请求

`post /api/v1/sessions`

### Request 请求参数

参数名 | 是否必需 | 描述
-----| --------| -------
email  |  是   | Emial|
password| 是   | Password|

```shell
  curl -i -X POST -d "email=test@topdmc.com&password=123456"  --header "Authorization: Token token=O8ATFEm4KxFJmT0jEg5FLYA==" http://localhost:3000/api/v1/sessions
```
### Response 响应

> 响应数据:

```json
{   
    access_token: token, expired_in_days: exp_days
}
```

## 2、用户列表接口

### HTTP请求

`get /api/v1/users`

### Request 请求参数

参数名 | 是否必需 | 描述
-----| --------| -------
email  |  否  | Emial|
name| 否   | name|
status | 否   | 状态|


```shell
  curl -i -X GET -d "email=test@topdmc.com&name=123456"  --header "Authorization: Token token=O8ATFEm4KxFJmT0jEg5FLYA==" http://localhost:3000/api/v1/users
```
### Response 响应

> 响应数据:

```json
users:[
  {   
    name,
    email,
    address,
    avatar_url,
    status
  },
....
]
```


## 2、新建用户接口

### HTTP请求

`POST /api/v1/users`

### Request 请求参数

参数名 | 是否必需 | 描述
-----| --------| -------
user[email]  |   是  | Emial|
user[name] | 是   | name|
user[password] | 是   | password|
user[address] | 是   | 地址|
user[status] | 是   | 状态|
user[phone] | 是   | 手机|
user[avatar_url] | 是   | 头像|
user[role_ids][] |是 | 角色列表|


```shell
  curl -i -X POST -d "user[email]=test@topdmc.com&user[name]=123456&user[password]=123456&user[address]=ssss&user[avatar_url]=sdfdfd&user[role_ids][]=1&user[role_ids]=2"  --header "Authorization: Token token=O8ATFEm4KxFJmT0jEg5FLYA==" http://localhost:3000/api/v1/users
```
### Response 响应

> 响应数据:

```json
  {   
  name,
  email,
  address,
  avatar_url,
  status
}
```


## 3、修改用户接口

### HTTP请求

`PUT /api/v1/users/:id`

### Request 请求参数

参数名 | 是否必需 | 描述
-----| --------| -------
user[email]  |   是  | Emial|
user[name] | 是   | name|
user[address] | 是   | 地址|
user[status] | 是   | 状态|
user[phone] | 是   | 手机|
user[avatar_url] | 是   | 头像|
user[role_ids][] |是 | 角色列表|


```shell
  curl -i -X PUT -d "user[email]=wh@topdmc.com&user[name]=123456&user[address]=ssss&user[avatar_url]=sdfdfd&user[role_ids]=1&user[role_ids]=2"  --header "Authorization: Token token=O8ATFEm4KxFJmT0jEg5FLYA==" http://localhost:3000/api/v1/users/:id
```
### Response 响应

> 响应数据:

```json
 {   
  name,
  email,
  address,
  avatar_url,
  status
}
```


## 4、查看用户接口

### HTTP请求

`GET /api/v1/users/:id`


```shell
  curl -i -X GET    --header "Authorization: Token token=O8ATFEm4KxFJmT0jEg5FLYA==" http://localhost:3000/api/v1/users/:id
```
### Response 响应

> 响应数据:

```json
 user:
   {   
    name,
    email,
    address,
    avatar_url,
    status
  }
```


## 5、删除用户接口

### HTTP请求

`DELETE /api/v1/users/:id`


```shell
  curl -i -X DELETE    --header "Authorization: Token token=O8ATFEm4KxFJmT0jEg5FLYA==" http://localhost:3000/api/v1/users/:id
```
### Response 响应

> 响应数据:

```json
 user:
   {   
    name,
    email,
    address,
    avatar_url,
    status
  }
```
# Part2 角色管理

## 2.1、角色列表接口

### HTTP请求

`get /api/v1/roles`

### Request 请求参数

```shell
  curl -i -X GET  --header "Authorization: Token token=O8ATFEm4KxFJmT0jEg5FLYA==" http://localhost:3000/api/v1/roles
```
### Response 响应

> 响应数据:

```json
roles:[
  {   
    name,
    status
  },
....
]
```

## 2.2、新建角色接口

### HTTP请求

`post /api/v1/roles`

### Request 请求参数

```shell
  curl -i -X POST  -d "role[name]=sdfdf&role[status]=0"--header "Authorization: Token token=O8ATFEm4KxFJmT0jEg5FLYA==" http://localhost:3000/api/v1/roles
```
### Response 响应

> 响应数据:

```json
  {   
    name,
    status
  }
```


## 2.3、修改角色接口

### HTTP请求

`PUT /api/v1/roles/:id`

### Request 请求参数

```shell
  curl -i -X PUT  -d "role[name]=sdfdf&role[status]=0"--header "Authorization: Token token=O8ATFEm4KxFJmT0jEg5FLYA==" http://localhost:3000/api/v1/roles/:id
```
### Response 响应

> 响应数据:

```json
  {   
    name,
    status
  }
```


## 2.4、删除角色接口

### HTTP请求

`DELETE /api/v1/roles/:id`

### Request 请求参数

```shell
  curl -i -X DELETE --header "Authorization: Token token=O8ATFEm4KxFJmT0jEg5FLYA==" http://localhost:3000/api/v1/roles/:id
```
