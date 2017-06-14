
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
| website                          | 否    | 网站                    |
| artist_names_attributes_name     | 否   |  艺人多语言姓名名称          |
| artist_names_attributes_language | 否   |  艺人多语言姓名语言          |
| songs_attributes_url         | 否    | 资源URL                    |
| songs_attributes_native_name | 否    | 文件原始名称                   |
| images_attributes_url         | 否    | 资源URL                    |
| images_attributes_native_name | 否    | 文件原始名称                   |

#### 请求示例
`post /api/v1/artists`
```json
{
  "artist":{
    "name":"test_multi_name",
    "country_id":"1",
    "gender_type":"female",
    "description":"aaaaaaaaaaaaaa",
    "label_id":"1",
    "website": "www.maplegz.com",
    "artist_names_attributes": [{
    	"name": "maple",
    	"language_name": "英语"
    }],
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
    "id": 72,
    "name": "test_multi_name",
    "label_id": 1,
    "label_name": "dddaaa",
    "gender_type": "female",
    "description": "aaaaaaaaaaaaaa",
    "deleted": false,
    "website": "www.maplegz.com",
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
        "id": 560,
        "url": "1aaaaadd44444ssssaa,,.ssa.mp3",
        "deleted": false,
        "native_name": "1ddaalllllll",
        "created_at": "2017-06-07T17:54:34.000+08:00",
        "updated_at": "2017-06-07T17:54:34.000+08:00"
      }
    ],
    "images": [
      {
        "id": 561,
        "url": "1saa,,.ssa.avi",
        "deleted": false,
        "native_name": "1ddaalllllll",
        "created_at": "2017-06-07T17:54:34.000+08:00",
        "updated_at": "2017-06-07T17:54:34.000+08:00"
      }
    ],
    "approve": {
      "approver_name": "",
      "approve_at": "",
      "status": "pending",
      "creator_name": "",
      "created_at": "2017-06-07T17:54:33.000+08:00",
      "updated_at": "2017-06-07T17:54:33.000+08:00",
      "not_through_reason": ""
    },
    "artist_names": [
      {
        "id": 3,
        "artist_id": 72,
        "name": "maple",
        "language_name": "英语",
        "created_at": "2017-06-07T17:54:34.000+08:00",
        "updated_at": "2017-06-07T17:54:34.000+08:00"
      }
    ]
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

## 3.6、审核不通过版

### HTTP请求

`POST  /api/v1/artists/:id/reject`

### Request 请求参数

| 参数名    | 是否必需 | 描述    |
| ------ | ---- | ----- |
| id   | 是    | 版权方id |
| not_through_reason  |  是    |  未通过原因 |

### Request 请求

```json
{
"id": 1,
"not_through_reason": "dddd"
}

```
### Response 响应

> 响应数据:
null


## 3.7、批量审核通过

### HTTP请求

`POST  /api/v1/artists/accept`

### Request 请求参数

| 参数名    | 是否必需 | 描述    |
| ------ | ---- | ----- |
| artist_ids   | 是    | 版权方id |


### Request 请求

```json
{
"artist_ids": [1,2]
}

```
### Response 响应

> 响应数据:
null
