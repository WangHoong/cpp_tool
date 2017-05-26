
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


# Part3 艺人管理

## 3.1. 创建艺人接口

### HTTP请求

`post /api/v1/artists`

### Request 请求参数

| 参数名                              | 是否必需 | 描述                       |
| -------------------------------- | ---- | ------------------------ |
| artist                           | 是    | 标志是艺人                    |
| name                             | 是    | 艺人名称                     |
| country_id                       | 否    | 国家ID                     |
| country_name                     | 否    | 国家名称                     |
| gender_type                      | 否    | 性别 [:male,:female,:team] |
| description                      | 否    | 备注                       |
| label_id                         | 否    | 唱片公司ID                   |
| label_name                       | 否    | 唱片公司名称                   |
| songs_attributes_url         | 否    | 资源URL                    |
| songs_attributes_native_name | 否    | 文件原始名称                   |
| images_attributes_url         | 否    | 资源URL                    |
| images_attributes_native_name | 否    | 文件原始名称                   |

#### 请求示例
`post /api/v1/artists`
```json
{
	"artist":{
		"name":"222222",
		"country_id":"1",
		"gender_type":"female",
		"description":"aaaaaaaaaaaaaa",
		"label_id":"1",
		"label_name":"dddaaa",
		"songs_attributes":[{
			"url":"1aaaaadd44444ssssaa,,.ssa.mp3",
			"native_name":"1ddaalllllll"
		}],
		"images_attributes":[{
			"url":"1saa,,.ssa.avi",
			"native_name":"1ddaalllllll"
		}]
	}

}
```

### Response 响应

> 响应数据:

```json
{
  "artist": {
    "id": 12,
    "name": "222222",
    "label_id": 1,
    "label_name": "dddaaa",
    "gender_type": "female",
    "description": "aaaaaaaaaaaaaa",
    "deleted": false,
    "country": {
      "id": 1,
      "continent_id": 3,
      "name": "Cameroon",
      "lower_name": "the republic of cameroon",
      "country_code": "CMR",
      "full_name": "the Republic of Cameroon",
      "cname": "喀麦隆",
      "full_cname": "喀麦隆共和国",
      "remark": "喀麦隆共和国（法语：République du Cameroun）通称喀麦隆，是位于非洲中西部的单一制共和国，西方与尼日利亚接壤，东北与东边分别和乍得与中非相靠，南方则与赤道几内亚、加蓬及刚果共和国毗邻。"
    },
    "songs": [
      {
        "id": 20,
        "url": "1aaaaadd44444ssssaa,,.ssa.mp3",
        "deleted": false,
        "native_name": "1ddaalllllll",
        "created_at": "2017-05-10T14:47:53.000+08:00",
        "updated_at": "2017-05-10T14:47:53.000+08:00"
      }
    ],
    "images": [
      {
        "id": 21,
        "url": "1saa,,.ssa.avi",
        "deleted": false,
        "native_name": "1ddaalllllll",
        "created_at": "2017-05-10T14:47:53.000+08:00",
        "updated_at": "2017-05-10T14:47:53.000+08:00"
      }
    ],
    "approve": {
      "approver_name": "",
      "approve_at": "",
      "status": "pending",
      "creator_name": "",
      "created_at": "2017-05-10T14:47:53.000+08:00",
      "updated_at": "2017-05-10T14:47:53.000+08:00",
      "not_through_reason": ""
    }
  }
}
```
## 3.2. 删除艺人接口

### HTTP请求

`delete /api/v1/artists/:id`

### Request 请求参数


| 参数名  | 是否必需 | 描述   |
| ---- | ---- | ---- |
| id   | 是    | 艺人ID |

#### 请求示例

`delete /api/v1/artists/8`

### Response 响应

> 响应数据:

```json
{
  "artist": {
    "id": 12,
    "name": "222222",
    "label_id": 1,
    "label_name": "dddaaa",
    "gender_type": "female",
    "description": "aaaaaaaaaaaaaa",
    "deleted": true,
    "country": {
      "id": 1,
      "continent_id": 3,
      "name": "Cameroon",
      "lower_name": "the republic of cameroon",
      "country_code": "CMR",
      "full_name": "the Republic of Cameroon",
      "cname": "喀麦隆",
      "full_cname": "喀麦隆共和国",
      "remark": "喀麦隆共和国（法语：République du Cameroun）通称喀麦隆，是位于非洲中西部的单一制共和国，西方与尼日利亚接壤，东北与东边分别和乍得与中非相靠，南方则与赤道几内亚、加蓬及刚果共和国毗邻。"
    },
    "songs": [],
    "images": [],
    "approve": {
      "approver_name": "",
      "approve_at": "",
      "status": "pending",
      "creator_name": "",
      "created_at": "2017-05-10T14:47:53.000+08:00",
      "updated_at": "2017-05-10T14:47:53.000+08:00",
      "not_through_reason": ""
    }
  }
}
```
## 3.3. 更新艺人接口

### HTTP请求

`put /api/v1/artists/:id`

### Request 请求参数

| 参数名                              | 是否必需 | 描述                           |
| -------------------------------- | ---- | ---------------------------- |
| id                               | 是    | 艺人ID                         |
| artist                           | 是    | 标志是艺人                        |
| name                             | 否    | 艺人名称                         |
| country_id                       | 否    | 国家ID                         |
| country_name                     | 否    | 国家名称                         |
| gender_type                      | 否    | 性别 [:male,:female,:team]     |
| description                      | 否    | 备注                           |
| label_id                         | 否    | 唱片公司ID                       |
| label_name                       | 否    | 唱片公司名称                       |
| songs_attributes_id          | 否    | 艺人资源id                         |
| songs_attributes__destroy    | 否    | 是否删除艺人资源文件[true,false] |
| songs_attributes_url         | 否    | 资源URL                    |
| songs_attributes_native_name | 否    | 文件原始名称                   |
| images_attributes_id          | 否    | 艺人资源id                         |
| images_attributes__destroy    | 否    | 是否删除艺人资源文件[true,false] |
| images_attributes_url         | 否    | 资源URL                    |
| images_attributes_native_name | 否    | 文件原始名称                   |

 注意⚠️ 更新artist_resources_attributes里面原有数据时候要加入艺人资源id ，如果不加艺人资源id 会创建新的数据,当不删除artist_resources_attributes里面数据时候_destroy 为false或不传此参数

#### 请求示例

`put /api/v1/artists/3`
```json
{
	"artist":{
		"name":"222222",
		"country_id":"1",
		"gender_type":"female",
		"description":"aaaaaaxxxxxxaaaaaaaa",
		"label_id":"1",
		"label_name":"dddaaa",
		"songs_attributes":[{
			"id": 19,
		   "_destroy": true,
			"url":"1aaaaadd44444ssssaa,,.ssa.mp3",
			"native_name":"1ddaalllllll"
		}]
	}

}
```
### Response 响应

> 响应数据:

```json
{
  "artist": {
    "id": 11,
    "name": "222222",
    "label_id": 1,
    "label_name": "dddaaa",
    "gender_type": "female",
    "description": "aaaaaaxxxxxxaaaaaaaa",
    "deleted": false,
    "country": {
      "id": 1,
      "continent_id": 3,
      "name": "Cameroon",
      "lower_name": "the republic of cameroon",
      "country_code": "CMR",
      "full_name": "the Republic of Cameroon",
      "cname": "喀麦隆",
      "full_cname": "喀麦隆共和国",
      "remark": "喀麦隆共和国（法语：République du Cameroun）通称喀麦隆，是位于非洲中西部的单一制共和国，西方与尼日利亚接壤，东北与东边分别和乍得与中非相靠，南方则与赤道几内亚、加蓬及刚果共和国毗邻。"
    },
    "songs": [],
    "images": [
      {
        "id": 18,
        "url": "1saa,,.ssa.avi",
        "deleted": false,
        "native_name": "1ddaalllllll",
        "created_at": "2017-05-10T14:41:02.000+08:00",
        "updated_at": "2017-05-10T14:41:02.000+08:00"
      }
    ],
    "approve": {
      "approver_name": "",
      "approve_at": "",
      "status": "pending",
      "creator_name": "",
      "created_at": "2017-05-10T14:39:17.000+08:00",
      "updated_at": "2017-05-10T14:49:39.000+08:00",
      "not_through_reason": ""
    }
  }
}
```
## 3.4. 查询艺人列表接口

### HTTP请求

`get /api/v1/artists?size=2&page=2`

### Request 请求参数


| 参数名  | 是否必需 | 描述      |
| ---- | ---- | ------- |
| size | 是    | 每页显示的条数 |
| page | 否    | 第几页     |

#### 请求示例

`get /api/v1/artists?size=2&page=1`

### Response 响应

> 响应数据:

```json
{
  "artists": [
    {
      "id": 15,
      "name": "222222",
      "label_id": 1,
      "label_name": "dddaaa",
      "gender_type": "female",
      "description": "aaaaaaaaaaaaaa",
      "deleted": false,
      "country": {
        "id": 1,
        "continent_id": 3,
        "name": "Cameroon",
        "lower_name": "the republic of cameroon",
        "country_code": "CMR",
        "full_name": "the Republic of Cameroon",
        "cname": "喀麦隆",
        "full_cname": "喀麦隆共和国",
        "remark": "喀麦隆共和国（法语：République du Cameroun）通称喀麦隆，是位于非洲中西部的单一制共和国，西方与尼日利亚接壤，东北与东边分别和乍得与中非相靠，南方则与赤道几内亚、加蓬及刚果共和国毗邻。"
      },
      "songs": [
        {
          "id": 26,
          "url": "1aaaaadd44444ssssaa,,.ssa.mp3",
          "deleted": false,
          "native_name": "1ddaalllllll",
          "created_at": "2017-05-10T14:54:06.000+08:00",
          "updated_at": "2017-05-10T14:54:06.000+08:00"
        }
      ],
      "images": [
        {
          "id": 27,
          "url": "1saa,,.ssa.avi",
          "deleted": false,
          "native_name": "1ddaalllllll",
          "created_at": "2017-05-10T14:54:06.000+08:00",
          "updated_at": "2017-05-10T14:54:06.000+08:00"
        }
      ],
      "approve": {
        "approver_name": "",
        "approve_at": "",
        "status": "pending",
        "creator_name": "",
        "created_at": "2017-05-10T14:54:06.000+08:00",
        "updated_at": "2017-05-10T14:54:06.000+08:00",
        "not_through_reason": ""
      }
    },
    {
      "id": 14,
      "name": "222222",
      "label_id": 1,
      "label_name": "dddaaa",
      "gender_type": "female",
      "description": "aaaaaaaaaaaaaa",
      "deleted": false,
      "country": {
        "id": 1,
        "continent_id": 3,
        "name": "Cameroon",
        "lower_name": "the republic of cameroon",
        "country_code": "CMR",
        "full_name": "the Republic of Cameroon",
        "cname": "喀麦隆",
        "full_cname": "喀麦隆共和国",
        "remark": "喀麦隆共和国（法语：République du Cameroun）通称喀麦隆，是位于非洲中西部的单一制共和国，西方与尼日利亚接壤，东北与东边分别和乍得与中非相靠，南方则与赤道几内亚、加蓬及刚果共和国毗邻。"
      },
      "songs": [
        {
          "id": 24,
          "url": "1aaaaadd44444ssssaa,,.ssa.mp3",
          "deleted": false,
          "native_name": "1ddaalllllll",
          "created_at": "2017-05-10T14:54:05.000+08:00",
          "updated_at": "2017-05-10T14:54:05.000+08:00"
        }
      ],
      "images": [
        {
          "id": 25,
          "url": "1saa,,.ssa.avi",
          "deleted": false,
          "native_name": "1ddaalllllll",
          "created_at": "2017-05-10T14:54:05.000+08:00",
          "updated_at": "2017-05-10T14:54:05.000+08:00"
        }
      ],
      "approve": {
        "approver_name": "",
        "approve_at": "",
        "status": "pending",
        "creator_name": "",
        "created_at": "2017-05-10T14:54:05.000+08:00",
        "updated_at": "2017-05-10T14:54:05.000+08:00",
        "not_through_reason": ""
      }
    }
  ],
  "meta": {
    "page": 1,
    "total": 3
  }
}
```
## 3.5. 查询艺人详情接口

### HTTP请求

`get /api/v1/artists/:id`

### Request 请求参数


| 参数名  | 是否必需 | 描述   |
| ---- | ---- | ---- |
| id   | 是    | 艺人ID |

#### 请求示例

`get /api/v1/artists/8`
### Response 响应

> 响应数据:

```json
{
  "artist": {
    "id": 15,
    "name": "222222",
    "label_id": 1,
    "label_name": "dddaaa",
    "gender_type": "female",
    "description": "aaaaaaaaaaaaaa",
    "deleted": false,
    "country": {
      "id": 1,
      "continent_id": 3,
      "name": "Cameroon",
      "lower_name": "the republic of cameroon",
      "country_code": "CMR",
      "full_name": "the Republic of Cameroon",
      "cname": "喀麦隆",
      "full_cname": "喀麦隆共和国",
      "remark": "喀麦隆共和国（法语：République du Cameroun）通称喀麦隆，是位于非洲中西部的单一制共和国，西方与尼日利亚接壤，东北与东边分别和乍得与中非相靠，南方则与赤道几内亚、加蓬及刚果共和国毗邻。"
    },
    "songs": [
      {
        "id": 26,
        "url": "1aaaaadd44444ssssaa,,.ssa.mp3",
        "deleted": false,
        "native_name": "1ddaalllllll",
        "created_at": "2017-05-10T14:54:06.000+08:00",
        "updated_at": "2017-05-10T14:54:06.000+08:00"
      }
    ],
    "images": [
      {
        "id": 27,
        "url": "1saa,,.ssa.avi",
        "deleted": false,
        "native_name": "1ddaalllllll",
        "created_at": "2017-05-10T14:54:06.000+08:00",
        "updated_at": "2017-05-10T14:54:06.000+08:00"
      }
    ],
    "approve": {
      "approver_name": "",
      "approve_at": "",
      "status": "pending",
      "creator_name": "",
      "created_at": "2017-05-10T14:54:06.000+08:00",
      "updated_at": "2017-05-10T14:54:06.000+08:00",
      "not_through_reason": ""
    }
  }
}

```
## 3.6. 批量审核通过艺人接口

### HTTP请求

`post /api/v1/artists/approve`

### Request 请求参数


| 参数名        | 是否必需 | 描述     |
| ---------- | ---- | ------ |
| artist_ids | 是    | 艺人ID数组 |

#### 请求示例

`post /api/v1/artists/approve`
```json
{
"artist_ids":[6,7]
}
```

### Response 响应

> 响应数据:

```json
{
  "artists": [
    {
      "id": 13,
      "name": "222222",
      "label_id": 1,
      "label_name": "dddaaa",
      "gender_type": "female",
      "description": "aaaaaaaaaaaaaa",
      "deleted": false,
      "country": {
        "id": 1,
        "continent_id": 3,
        "name": "Cameroon",
        "lower_name": "the republic of cameroon",
        "country_code": "CMR",
        "full_name": "the Republic of Cameroon",
        "cname": "喀麦隆",
        "full_cname": "喀麦隆共和国",
        "remark": "喀麦隆共和国（法语：République du Cameroun）通称喀麦隆，是位于非洲中西部的单一制共和国，西方与尼日利亚接壤，东北与东边分别和乍得与中非相靠，南方则与赤道几内亚、加蓬及刚果共和国毗邻。"
      },
      "songs": [
        {
          "id": 22,
          "url": "1aaaaadd44444ssssaa,,.ssa.mp3",
          "deleted": false,
          "native_name": "1ddaalllllll",
          "created_at": "2017-05-10T14:54:04.000+08:00",
          "updated_at": "2017-05-10T14:54:04.000+08:00"
        }
      ],
      "images": [
        {
          "id": 23,
          "url": "1saa,,.ssa.avi",
          "deleted": false,
          "native_name": "1ddaalllllll",
          "created_at": "2017-05-10T14:54:05.000+08:00",
          "updated_at": "2017-05-10T14:54:05.000+08:00"
        }
      ],
      "approve": {
        "approver_name": "",
        "approve_at": "2017-05-10T14:58:46.000+08:00",
        "status": "accepted",
        "creator_name": "",
        "created_at": "2017-05-10T14:54:04.000+08:00",
        "updated_at": "2017-05-10T14:58:46.000+08:00",
        "not_through_reason": ""
      }
    },
    {
      "id": 14,
      "name": "222222",
      "label_id": 1,
      "label_name": "dddaaa",
      "gender_type": "female",
      "description": "aaaaaaaaaaaaaa",
      "deleted": false,
      "country": {
        "id": 1,
        "continent_id": 3,
        "name": "Cameroon",
        "lower_name": "the republic of cameroon",
        "country_code": "CMR",
        "full_name": "the Republic of Cameroon",
        "cname": "喀麦隆",
        "full_cname": "喀麦隆共和国",
        "remark": "喀麦隆共和国（法语：République du Cameroun）通称喀麦隆，是位于非洲中西部的单一制共和国，西方与尼日利亚接壤，东北与东边分别和乍得与中非相靠，南方则与赤道几内亚、加蓬及刚果共和国毗邻。"
      },
      "songs": [
        {
          "id": 24,
          "url": "1aaaaadd44444ssssaa,,.ssa.mp3",
          "deleted": false,
          "native_name": "1ddaalllllll",
          "created_at": "2017-05-10T14:54:05.000+08:00",
          "updated_at": "2017-05-10T14:54:05.000+08:00"
        }
      ],
      "images": [
        {
          "id": 25,
          "url": "1saa,,.ssa.avi",
          "deleted": false,
          "native_name": "1ddaalllllll",
          "created_at": "2017-05-10T14:54:05.000+08:00",
          "updated_at": "2017-05-10T14:54:05.000+08:00"
        }
      ],
      "approve": {
        "approver_name": "",
        "approve_at": "2017-05-10T14:58:46.000+08:00",
        "status": "accepted",
        "creator_name": "",
        "created_at": "2017-05-10T14:54:05.000+08:00",
        "updated_at": "2017-05-10T14:58:46.000+08:00",
        "not_through_reason": ""
      }
    }
  ]
}
```

## 3.6.  单个审核艺人接口

### HTTP请求

`post /api/v1/artists/:id/approve`

### Request 请求参数


| 参数名        | 是否必需 | 描述     |
| ---------- | ---- | ------ |
| not_through_reason | 否    | 不通过原因 |
| status | 是    | 要更改状态，reject，accept |

#### 请求示例

`post /api/v1/artists/1/approve`
```json
{
	"artist":{
		"not_through_reason":"222222",
		"status":"reject"
	}

}
```

### Response 响应

> 响应数据:

```json
{
  "artist": {
    "id": 15,
    "name": "222222",
    "label_id": 1,
    "label_name": "dddaaa",
    "gender_type": "female",
    "description": "aaaaaaaaaaaaaa",
    "deleted": false,
    "country": {
      "id": 1,
      "continent_id": 3,
      "name": "Cameroon",
      "lower_name": "the republic of cameroon",
      "country_code": "CMR",
      "full_name": "the Republic of Cameroon",
      "cname": "喀麦隆",
      "full_cname": "喀麦隆共和国",
      "remark": "喀麦隆共和国（法语：République du Cameroun）通称喀麦隆，是位于非洲中西部的单一制共和国，西方与尼日利亚接壤，东北与东边分别和乍得与中非相靠，南方则与赤道几内亚、加蓬及刚果共和国毗邻。"
    },
    "songs": [
      {
        "id": 26,
        "url": "1aaaaadd44444ssssaa,,.ssa.mp3",
        "deleted": false,
        "native_name": "1ddaalllllll",
        "created_at": "2017-05-10T14:54:06.000+08:00",
        "updated_at": "2017-05-10T14:54:06.000+08:00"
      }
    ],
    "images": [
      {
        "id": 27,
        "url": "1saa,,.ssa.avi",
        "deleted": false,
        "native_name": "1ddaalllllll",
        "created_at": "2017-05-10T14:54:06.000+08:00",
        "updated_at": "2017-05-10T14:54:06.000+08:00"
      }
    ],
    "approve": {
      "approver_name": "",
      "approve_at": "2017-05-10T15:01:47.000+08:00",
      "status": "accepted",
      "creator_name": "",
      "created_at": "2017-05-10T14:54:06.000+08:00",
      "updated_at": "2017-05-10T15:01:47.000+08:00",
      "not_through_reason": ""
    }
  }
}
```





# Part7 合约管理

## 7.1、合约列表接口

### HTTP请求

`GET /api/v1/cp/contracts`

### Request 请求参数

| 参数名    | 是否必需 | 描述    |
| ------ | ---- | ----- |
| contract_no   | 是    | 合约编号  |
| provider_name  |  是    |  版权方 |
| project_no  |  是    |  版权方 |
| contract_status  |  是    |  合约状态(valid:有效,near:快到期,due:过期,unvalid:未生效) |

```shell
  curl -i -X GET   --header "Authorization: Token token=O8ATFEm4KxFJmT0jEg5FLYA==" http://localhost:3000/api/v1/cp/contracts
```
### Response 响应

> 响应数据:

```json
{
  "contracts": [
    {
      "id": 2,
      "contract_no": "test",
      "project_no": "company",
      "provider_name": "sdfdfd",
      "authorize_valid_cnt": "有效授权数量",
      "authorize_due_cnt": "过期授权数量",
      "status" : "状态",
      "contract_status" : "合约状态",
      "updated_at": "2017-04",
      "start_time": null,
      "end_time": null
    }
  ],
  "meta": {
    "page": 1,
    "total": 1,
    "size": 10
  }
}
```

## 7.2、新建合约

### HTTP请求

`POST  /api/v1/cp/contracts`

### Request 请求参数


```json
    {"contract":
	     {
	      "provider_id":2,
	     "department_id":1,
         "project_no":"32323",
         "contract_no":"32323",
         "start_time":"2016-11-17","end_time":"2017-12-17",
         "allow_overdue":false,"pay_type":"default",
         "pay_amount":10,"desc":"dfdfdfsss",
         "contract_resources_attributes": [{"url":"33333","file_name":"eeeeee"}],
         "authorizes_attributes":[{"currency_id":1,"account_id":1,
         "start_time":"2016-11-17","end_time":"2016-12-17",
          "contract_resources_attributes":[{"url":"33333","file_name":"eeeeee"}],
          "authorized_businesses_attributes":[{"authorized_range_id":1,"divided_point":50,
          "authorized_area_ids":[124]}]
          }]
      }
}

```

### Response 响应

> 响应数据:
 null

## 7.3、修改合约

### HTTP请求

`PUT  /api/v1/cp/contracts/1`

### Request 请求参数


```json
{"contract":
   {
    "id":2
    "provider_id":2,
   "department_id":1,
     "project_no":"32323",
     "contract_no":"32323",
     "start_time":"2016-11-17","end_time":"2017-12-17",
     "allow_overdue":false,"pay_type":"default",
     "pay_amount":10,"desc":"dfdfdfsss",
     "contract_resources_attributes":[{"id":1,"url":"33333","file_name":"eeeeee"}],
     "authorizes_attributes":[{"id":2,"currency_id":1,"account_id":1,
     "start_time":"2016-11-17","end_time":"2016-12-17",
      "contract_resources_attributes":[{"id":1,"url":"33333","file_name":"eeeeee"}],
      "authorized_businesses_attributes":[{"id":2,"authorized_range_id":1,"divided_point":50,
      "authorized_area_ids":[124]}]
      }]
  }
}
```

### Response 响应

> 响应数据:
 null



## 7.4、合约详情

### HTTP请求

`GET  /api/v1/cp/contracts/1`

### Response 响应

> 响应数据:

```json
{
  "contract": {
          "id":18,"provider_id":1,"provider_name":"版权方",
          "project_no":"ssss","contract_no":"sssss",
          "signing_company":"32aa","start_time":"2016-11-17",
          "end_time":"2016-12-17","allow_overdue":false,
          "pay_type":"default","pay_amount":10,"desc":"dfdfdfsss","reason":"dddd",
          "contract_resources": [
              {
                "id": 2,
                "target_id": 18,
                "target_type": "Cp::Contract",
                "file_name": "dfdf",
                "url": "33333"
              }
            ],
          "authorizes":[{"id":29,"currency_id":1,"account_id":1,
              "start_time":"2016-11-17","end_time":"2016-12-17",
              "contract_resources": [
                  {
                    "id": 1,
                    "target_id": 18,
                    "target_type": "Cp::Authorize",
                    "file_name": "dfdfd",
                    "url": "33333"
                  }
                ],
              "authorized_businesses":[{"id":93,"business_id":1,
              "business_type":"AuthorizedRange","is_whole":0,"divided_point":50,
              "authorized_area_ids":[124]}]
          }]
        }
}
```


## 7.5、删除合约

### HTTP请求

`DELETE  /api/v1/cp/contracts/1`

### Response 响应

> 响应数据:
 NULL


## 7.6、批量通过合约

### HTTP请求

`POST  /api/v1/cp/contracts/verify`

### Request 请求参数

| 参数名    | 是否必需 | 描述    |
| ------ | ---- | ----- |
| contract_ids   | 是    | 版权方ids  |


### Request 请求

```json
{
 "contract_ids": [1,2]
}

```

### Response 响应

> 响应数据:
null

## 7.7、批量不通过合约

### HTTP请求

`POST  /api/v1/cp/contracts/unverify`

### Request 请求参数

| 参数名    | 是否必需 | 描述    |
| ------ | ---- | ----- |
| id   | 是    | 版权方id  |
| reason  |  是    |  未通过原因 |

### Request 请求

```json
{
 "id": 1,
 "reason": "dddd"
}

```
### Response 响应

> 响应数据:
null

# Part8 结算管理

## 8.1. 创建货币接口

### HTTP请求

`post /api/v1/exchange_rates`

### Request 请求参数

| 参数名                              | 是否必需 | 描述                       |
| -------------------------------- | ---- | ------------------------ |
| exchange_rate                           | 是    | 标志是货币                    |
| currency_id                             | 是    | 货币_id                     |
| settlement_currency_id                       | 是    | 结算货币_id                    |
| exchange_ratio                     | 是   |      汇率                |
| status                      | 是   | 状态 [:enabled, :disabled] |
| operator                      | 是   | 操作人                       |

#### 请求示例
`post /api/v1/exchange_rates`
```json
{
	"exchange_rate":{
		"currency_id":3,
		"settlement_currency_id":1,
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
    "operator": "aasd",
    "created_at": "2017-05-11T17:08:08.000+08:00",
    "updated_at": "2017-05-11T17:11:52.000+08:00"
  }
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
