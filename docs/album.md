# Part3 专辑管理

## 3.1. 创建专辑接口

### HTTP请求

`post /api/v1/albums`

### Request 请求参数

| 参数名                              | 是否必需 | 描述                       |
| -------------------------------- | ---- | ------------------------ |
| album                           | 是    | 标志是专辑                    |
| name                             | 是    | 专辑名称                     |
| primary_artist_ids               | 否    | 主唱歌手 IDs                     |
| featuring_artist_ids             | 否    | 副唱歌手 IDs                     |
| language_id                      | 否    | 语音 ID                    |
| genre                            | 否    | 曲风                       |
| format                           | 否    | 专辑类型                   |
| label                            | 否    | 唱片公司名称                   |
| upc                              | 否    | UPC                   |
| release_version                  | 否    | 发行版本                    |
| remark                           | 否    | 备注                   |
| songs_attributes                 | 否    | 歌曲资料                |
| images_attributes                | 否    | 专辑图片                 |

#### 请求示例
`post /api/v1/albums`
```json
{
	"album": {
		"name": "genre",
		"primary_artist_ids": [1],
		"language_id": 1,
		"genre": "folk",
		"format": "ep",
		"label": "sdsdfsdf",
		"upc": "IOS_SDFSDFFWFWf--s9293242",
		"release_version": "v1000",
		"remark": "sfdsdfnsfksnvksnvkjnvkjnv",
		"songs_attributes": [
			{
				"url": "www.baidu.com",
				"native_name": "夫子"
			}
		],
		"images_attributes": [
			{
				"url": "www.taihe.com",
				"native_name": "sss"
			}
		]
	}
}

}
```

### Response 响应

> 响应数据:

```json
{
  "album": {
    "id": 9,
    "name": "genre",
    "genre": "folk",
    "format": "ep",
    "label": "sdsdfsdf",
    "release_version": "v1000",
    "remark": "sfdsdfnsfksnvksnvkjnvkjnv",
    "upc": "IOS_SDFSDFFWFWf--s9293242",
    "primary_artists": [
      {
        "id": 1,
        "name": "sdfsfs"
      }
    ],
    "featuring_artists": [],
    "songs": [
      {
        "id": 12,
        "url": "www.baidu.com",
        "native_name": "夫子"
      }
    ],
    "images": [
      {
        "id": 13,
        "url": "www.taihe.com",
        "native_name": "sss"
      }
    ],
    "language": {
      "name": "国语"
    }
  }
}
```
## 3.2. 删除专辑接口

### HTTP请求

`delete /api/v1/albums/:id`

### Request 请求参数


| 参数名  | 是否必需 | 描述   |
| ---- | ---- | ---- |
| id   | 是    | 专辑ID |

#### 请求示例

`delete /api/v1/artists/9`

### Response 响应

> 响应数据:

```json
{
  "album": {
    "id": 9,
    "name": "genre",
    "genre": "folk",
    "format": "ep",
    "label": "sdsdfsdf",
    "release_version": "v1000",
    "remark": "sfdsdfnsfksnvksnvkjnvkjnv",
    "upc": "IOS_SDFSDFFWFWf--s9293242",
    "primary_artists": [],
    "featuring_artists": [],
    "songs": [],
    "images": [],
    "language": {
      "name": "国语"
    }
  }
}
```
## 3.3. 更新专辑接口

### HTTP请求

`put /api/v1/albums/:id`

### Request 请求参数

| 参数名                              | 是否必需 | 描述                           |
| -------------------------------- | ---- | ---------------------------- |
| id                               | 是    | 专辑ID                         |
| album                            | 是    | 标志是专辑                        |
| name                             | 是    | 专辑名称                     |
| primary_artist_ids               | 否    | 主唱歌手 IDs                     |
| featuring_artist_ids             | 否    | 副唱歌手 IDs                     |
| language_id                      | 否    | 语音 ID                    |
| genre                            | 否    | 曲风                       |
| format                           | 否    | 专辑类型                   |
| label                            | 否    | 唱片公司名称                   |
| upc                              | 否    | UPC                   |
| release_version                  | 否    | 发行版本                    |
| remark                           | 否    | 备注                   |
| songs_attributes                 | 否    | 歌曲资料                |
| images_attributes                | 否    | 专辑图片                 |

 注意⚠️ 更新songs_attributes里面原有数据时候要加入song资源id ，如果不加资源id 会创建新的数据, 如果拥有 `_destroy` 字段，并且为 true 和 `id` 字段, 表示删除此资源

#### 请求示例

`put /api/v1/albums/10`
```json
{
	"album": {
		"name": "222",
		"primary_artist_ids": [2],
		"language_id": 2,
		"genre": "pop",
		"label": "111",
		"upc": "222222",
		"release_version": "v1022200",
		"remark": "1111111",
		"songs_attributes": [
      {
        "url": "create",
				"native_name": "create"
      },
			{
				"id": 17,
				"url": "update",
				"native_name": "update"
			}, {
				"id": 16,
				"_destroy": true
			}
		]
	}
}
```
### Response 响应

> 响应数据:

```json
{
  "album": {
    "id": 10,
    "name": "222",
    "genre": "pop",
    "format": "ep",
    "label": "111",
    "release_version": "v1022200",
    "remark": "1111111",
    "upc": "222222",
    "primary_artists": [
      {
        "id": 2,
        "name": "sfsfsfffs"
      }
    ],
    "featuring_artists": [],
    "songs": [
      {
        "id": 17,
        "url": "update",
        "native_name": "update"
      }
    ],
    "images": [
      {
        "id": 15,
        "url": "www.taihe.com",
        "native_name": "sss"
      }
    ],
    "language": {
      "name": "英语"
    }
  }
}
```
## 3.4. 查询专辑列表接口

### HTTP请求

`get /api/v1/albums?size=2&page=1`

### Request 请求参数


| 参数名  | 是否必需 | 描述      |
| ---- | ---- | ------- |
| size | 是    | 每页显示的条数 |
| page | 否    | 第几页     |

#### 请求示例

`get /api/v1/albums?size=2&page=1`

### Response 响应

> 响应数据:

```json
{
  "albums": [
    {
      "id": 11,
      "name": "222",
      "genre": "pop",
      "format": "ep",
      "label": "111",
      "release_version": "v1022200",
      "remark": "1111111",
      "upc": "222222",
      "primary_artists": [
        {
          "id": 2,
          "name": "sfsfsfffs"
        }
      ],
      "featuring_artists": [],
      "songs": [],
      "images": [],
      "language": {
        "name": "英语"
      }
    },
    {
      "id": 10,
      "name": "222",
      "genre": "pop",
      "format": "ep",
      "label": "111",
      "release_version": "v1022200",
      "remark": "1111111",
      "upc": "222222",
      "primary_artists": [
        {
          "id": 2,
          "name": "sfsfsfffs"
        }
      ],
      "featuring_artists": [],
      "songs": [
        {
          "id": 17,
          "url": "update",
          "native_name": "update"
        }
      ],
      "images": [
        {
          "id": 15,
          "url": "www.taihe.com",
          "native_name": "sss"
        }
      ],
      "language": {
        "name": "英语"
      }
    }
  ],
  "meta": {
    "page": 1,
    "total": 6
  }
}
```
## 3.5. 查询专辑详情接口

### HTTP请求

`get /api/v1/albums/:id`

### Request 请求参数


| 参数名  | 是否必需 | 描述   |
| ---- | ---- | ---- |
| id   | 是    | 专辑ID |

#### 请求示例

`get /api/v1/albums/10`
### Response 响应

> 响应数据:

```json
{
  "album": {
    "id": 10,
    "name": "222",
    "genre": "pop",
    "format": "ep",
    "label": "111",
    "release_version": "v1022200",
    "remark": "1111111",
    "upc": "222222",
    "primary_artists": [
      {
        "id": 2,
        "name": "sfsfsfffs"
      }
    ],
    "featuring_artists": [],
    "songs": [
      {
        "id": 17,
        "url": "update",
        "native_name": "update"
      }
    ],
    "images": [
      {
        "id": 15,
        "url": "www.taihe.com",
        "native_name": "sss"
      }
    ],
    "language": {
      "name": "英语"
    }
  }
}
```


## 3.6、审核不通过版

### HTTP请求

`POST  /api/v1/albums/:id/reject`

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

`POST  /api/v1/albums/accept`

### Request 请求参数

| 参数名    | 是否必需 | 描述    |
| ------ | ---- | ----- |
| album_ids   | 是    | 版权方id |


### Request 请求

```json
{
"album_ids": [1,2]
}

```
### Response 响应

> 响应数据:
null
