
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



 # Part0 上传百度云

 ## 获取临时token接口

 ### 存放音频文件  `get /api/v1/sts/media_token`   

 ### 存放图片和歌词文件   `get /api/v1/sts/ro_token`


 ```shell
   curl -i -X GET    --header "Authorization: Token token=O8ATFEm4KxFJmT0jEg5FLYA==" http://localhost:3000/api/v1/sts/media_token
 ```
 ### Response 响应

 > 响应数据:

 ```json
 {
  "accessKeyId": "df502159289811e7b48f6f90ae7dae38",
  "secretAccessKey": "be27232a12d6499dbc91b0812eb11f75",
  "sessionToken": "6IHTZwTmedrcJnQLrsaLRTyb66q5fmhopK1ltkaCg=",
  "createTime": "2017-04-24T02:51:10Z",
  "expiration": "2017-04-24T14:51:10Z",
  "userId": "f0693d510e03495e9b4eebb48ce2d68e"
}
 ```

# Part1 用户管理

## 1.1、用户登录接口

### HTTP请求

`post /api/v1/sessions`

### Request 请求参数

| 参数名      | 是否必需 | 描述       |
| -------- | ---- | -------- |
| email    | 是    | Emial    |
| password | 是    | Password |

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

## 1.2、用户列表接口

### HTTP请求

`get /api/v1/users`

### Request 请求参数

| 参数名    | 是否必需 | 描述    |
| ------ | ---- | ----- |
| email  | 否    | Emial |
| name   | 否    | name  |
| status | 否    | 状态    |


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


## 1.3、新建用户接口

### HTTP请求

`POST /api/v1/users`

### Request 请求参数

| 参数名              | 是否必需 | 描述       |
| ---------------- | ---- | -------- |
| user[email]      | 是    | Emial    |
| user[name]       | 是    | name     |
| user[password]   | 是    | password |
| user[address]    | 是    | 地址       |
| user[status]     | 是    | 状态       |
| user[phone]      | 是    | 手机       |
| user[avatar_url] | 是    | 头像       |
| user[role_ids][] | 是    | 角色列表     |


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


## 1.4、修改用户接口

### HTTP请求

`PUT /api/v1/users/:id`

### Request 请求参数

| 参数名              | 是否必需 | 描述    |
| ---------------- | ---- | ----- |
| user[email]      | 是    | Emial |
| user[name]       | 是    | name  |
| user[address]    | 是    | 地址    |
| user[status]     | 是    | 状态    |
| user[phone]      | 是    | 手机    |
| user[avatar_url] | 是    | 头像    |
| user[role_ids][] | 是    | 角色列表  |


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


## 1.5、查看用户接口

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


## 1.6、删除用户接口

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

## 1.7、用户权限接口

### HTTP请求

`get /api/v1/users/current`

```shell
  curl -i -X GET    --header "Authorization: Token token=O8ATFEm4KxFJmT0jEg5FLYA==" http://localhost:3000/api/v1/users/current
```
### Response 响应
### 说明
rule_type(1:查看,2:编辑,3:审核）
User:用户管理,Role:角色管理,Artist:艺人管理,Album专辑管理,Track歌曲管理,Provider:版权方管理,Contract:合约管理,渠道数据列表,结算单列表,版权方账户记录,汇率管理,待结数据列表,Dsp:渠道方管理
> 响应数据:

```json
{
 "user": {
   "id": 1,
   "name": "123456",
   "email": "wh@topdmc.com",
   "phone": null,
   "avatar_url": "sdfdfd",
   "status": 1,
   "created_at": "2017-04-06T12:39:38.000+08:00",
   "updated_at": "2017-04-06T15:47:33.000+08:00",
   "roles_permissions": {
     "User": [ 1, 2 ],  
     "Role": [ 1, 2 ]
   }
 }
}
```



# Part2 角色管理

## 2.1、角色列表接口

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

## 2.2、新建角色接口

### HTTP请求

`post /api/v1/roles`

### Request 请求参数

| 参数名                    | 是否必需 | 描述   |
| ---------------------- | ---- | ---- |
| role[name]             | 是    | name |
| role[status]           | 是    | 状态   |
| role[permission_ids][] | 是    | 功能列表 |


```shell
  curl -i -X POST  -d "role[name]=sdfdf&role[status]=0&role[permission_ids][]=1"--header "Authorization: Token token=O8ATFEm4KxFJmT0jEg5FLYA==" http://localhost:3000/api/v1/roles
```
### Response 响应

> 响应数据:

```json
  {   
    name,
    status
  }
```


## 2.3、修改角色接口

### HTTP请求

`PUT /api/v1/roles/:id`

### Request 请求参数

| 参数名                    | 是否必需 | 描述   |
| ---------------------- | ---- | ---- |
| role[name]             | 是    | name |
| role[status]           | 是    | 状态   |
| role[permission_ids][] | 是    | 功能列表 |

```shell
  curl -i -X PUT  -d "role[name]=sdfdf&role[status]=0&role[permission_ids][]=1&&role[permission_ids][]=2"--header "Authorization: Token token=O8ATFEm4KxFJmT0jEg5FLYA==" http://localhost:3000/api/v1/roles/:id
```
### Response 响应

> 响应数据:

```json
  {   
    name,
    status
  }
```


## 2.4、查看角色接口

### HTTP请求

`GET /api/v1/roles/:id`

```shell
  curl -i -X GET  --header "Authorization: Token token=O8ATFEm4KxFJmT0jEg5FLYA==" http://localhost:3000/api/v1/roles/:id
```
### Response 响应

> 响应数据:

```json
  role: {   
    name,
    status,
    permissions: [{
      {"id":1,
      "name":"用户查看",
      "display_name":"查看"
      'status':1
      'rule_type': 1 权限类型(1:查询权限;2:编辑权限;3:审核)
    },
    ..
    ]
  }
```

## 2.5、删除角色接口

### HTTP请求

`DELETE /api/v1/roles/:id`

### Request 请求参数

```shell
  curl -i -X DELETE --header "Authorization: Token token=O8ATFEm4KxFJmT0jEg5FLYA==" http://localhost:3000/api/v1/roles/:id
```
## 2.6、角色功能列表接口

### HTTP请求

`GET /api/v1/roles/permissions`

### Request 请求参数

```shell
  curl -i -X GET --header "Authorization: Token token=O8ATFEm4KxFJmT0jEg5FLYA==" http://localhost:3000/api/v1/roles/permissions
```
### Response 响应

> 响应数据:

```json
{
  "groups":
   [{"id":1,
     "name":"系统管理",
     "subclass":[{
       "id":5,
       "name":"用户管理",
       "permissions": [{
               "id":1,
               "name":"用户查看",
               "display_name":"查看",
               "is_selectd" : true
              },
              {
                "id":2,
                "name":"用户编辑",
                "display_name":"编辑",
                "is_selectd" : true
               },
           ]},
         ....
      ]}
    ]
  }

```
 
## 8.2. 删除货币接口

### HTTP请求

`Delete /api/v1/exchange_rates/:id`

### Request 请求参数

| 参数名                              | 是否必需 | 描述                       |
| -------------------------------- | ---- | ------------------------ |
| id                           | 是    | 货币id                    |

#### 请求示例
`Delete /api/v1/exchange_rates/2`

### Response 响应

> 响应数据:

```json
{
  "exchange_rate": {
    "id": 8,
    "currency": {
      "id": 3,
      "name": "美元"
    },
    "settlement_currency": {
      "id": 1,
      "name": "人民币"
    },
    "exchange_ratio": "1:12",
    "status": "enabled",
    "operator": "aasd"
  }
}
```

## 8.3. 更新货币接口

### HTTP请求

`Put /api/v1/exchange_rates/:id`

### Request 请求参数

| 参数名                              | 是否必需 | 描述                       |
| -------------------------------- | ---- | ------------------------ |
| exchange_rate                           | 是    | 标志是货币                    |
| currency_id                             | 否    | 货币                     |
| settlement_currency_id                       | 否    | 结算货币                    |
| exchange_ratio                     | 否   |      汇率                |
| status                      | 否   | 状态 [:enabled, :disabled] |
| operator                      | 否   | 操作人                       |

#### 请求示例
`post /api/v1/exchange_rates/2`
```json
{
	"exchange_rate":{
		"currency_id":2,
		"settlement_currency":1,
		"exchange_ratio":"1:12",
		"status":"enabled",
		"operator":"aasd"
	}

}
```

### Response 响应

> 响应数据:

```json
{
  "exchange_rate": {
    "id": 7,
    "currency": {
      "id": 2,
      "name": "英镑"
    },
    "settlement_currency": {
      "id": 1,
      "name": "人民币"
    },
    "exchange_ratio": "1:12",
    "status": "enabled",
    "operator": "aasd"
  }
}
```
## 8.4. 查看货币列表接口

### HTTP请求

`get /api/v1/exchange_rates`

### Request 请求参数


#### 请求示例
`get /api/v1/exchange_rates`

### Response 响应

> 响应数据:

```json
{
  "exchange_rates": [
    {
      "id": 7,
      "currency": {
        "id": 2,
        "name": "英镑"
      },
      "settlement_currency": {
        "id": 1,
        "name": "人民币"
      },
      "exchange_ratio": "1:12",
      "status": "enabled",
      "operator": "aasd"
    },
    {
      "id": 6,
      "currency": {
        "id": 3,
        "name": "美元"
      },
      "settlement_currency": {
        "id": 1,
        "name": "人民币"
      },
      "exchange_ratio": "1:12",
      "status": "enabled",
      "operator": "aasd"
    },
    {
      "id": 5,
      "currency": {
        "id": 2,
        "name": "英镑"
      },
      "settlement_currency": {
        "id": 1,
        "name": "人民币"
      },
      "exchange_ratio": "1:12",
      "status": "enabled",
      "operator": "aasd"
    }
  ],
  "meta": {
    "page": 1,
    "total": 3
  }
}
```
## 8.5. 查看货币详情接口

### HTTP请求

`get /api/v1/exchange_rates/:id`

### Request 请求参数
| 参数名                              | 是否必需 | 描述                       |
| -------------------------------- | ---- | ------------------------ |
| id                           | 是    | 货币ID                    |

#### 请求示例
`get /api/v1/exchange_rates/2`

### Response 响应

> 响应数据:

```json
{
  "exchange_rate": {
    "id": 7,
    "currency": {
      "id": 2,
      "name": "英镑"
    },
    "settlement_currency": {
      "id": 1,
      "name": "人民币"
    },
    "exchange_ratio": "1:12",
    "status": "enabled",
    "operator": "aasd"
  }
}
```
