字段值解释说明

1、文件名以con_req_开头，后跟4位交易类型(8583定义)＋2位区分码(自定义)；

2、字段域clientTransType是客户端用于区分一个具体交易，其值跟文件名的后部分相同；

3、字段域msgType是8583定义的交易类型，也即文件名数字部分的前4位；

4、字段中如果属性值即value值为空，则在位图中表示不包含此值，与key值是否存在无关；