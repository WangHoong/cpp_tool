# Part5 结算管理

## 5.1. 创建结算接口

### HTTP请求

`post /api/v1/revenues`


### Response 响应

```json
{
 "revenue": {
	 "dsp_id": 1,
	 "currency_id": 1,
	 "start_time": "sdsdfsdf",
	 "end_time": "isrc",
	 "income": "1.2",
   "status": 0,
   "process_status": 0,
   "is_std": 0,
   "is_split":0
 }
}

```

## 5.2. 删除结算接口

### HTTP请求

`delete /api/v1/revenues/:id`

### Request 请求参数


| 参数名  | 是否必需 | 描述   |
| ---- | ---- | ---- |
| id   | 是    | 结算ID |


### Response 响应

> 响应数据:

## 3.3. 更新结算接口

### HTTP请求

`put /api/v1/revenues/:id`


```json
{
 "revenue": {
	 "id": 1,
	 "dsp_id": 1,
	 "currency_id": 1,
   "dsp_name":"渠道",
   "currency_name":"rmb",
	 "start_time": "sdsdfsdf",
	 "end_time": "isrc",
	 "income": "1.2",
   "status": 0,
   "process_status": 0,
   "is_std": 0,
   "is_split":0
 }
}
```
### Response 响应

```json
{
 "revenue": {
	 "id": 1,
	 "dsp_id": 1,
	 "currency_id": 1,
	 "start_time": "sdsdfsdf",
	 "end_time": "isrc",
	 "income": "1.2",
   "status": 0,
   "process_status": 0,
   "is_std": 0,
   "is_split":0
 }
}

```

## 5.4. 查询结算列表接口

### HTTP请求

`get /api/v1/revenues?size=2&page=1`

### Request 请求参数


| 参数名  | 是否必需 | 描述      |
| ---- | ---- | ------- |
| size | 是    | 每页显示的条数 |
| page | 否    | 第几页     |

#### 请求示例

`get /api/v1/revenues?size=2&page=1`

### Response 响应

> 响应数据:

```json
{
 "revenues": [{
	 "id": 1,
	 "dsp_id": 1,
	 "currency_id": 1,
	 "start_time": "sdsdfsdf",
	 "end_time": "isrc",
	 "income": "1.2",
   "status": 0,
   "process_status": 0,
   "is_std": 0,
   "is_split":0
 }],
  "meta": {
    "page": 1,
    "total": 6
  }
}
```



## 5.5. 查看结算接口

### HTTP请求

`get /api/v1/revenues/1`

### Response 响应

> 响应数据:

```json
{
 "revenue": {
	 "id": 1,
	 "dsp_id": 1,
	 "currency_id": 1,
   "dsp_name":"渠道",
   "currency_name":"rmb",
	 "start_time": "sdsdfsdf",
	 "end_time": "isrc",
	 "income": "1.2",
   "status": 0,
   "process_status": 0,
   "is_std": 0,
   "is_split":0
 }
}
```
