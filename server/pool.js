/**
 * 数据库连接池模块 --
 * 此模块应该在项目启动时
 * （尚未有任何客户端连接请求时）
 * 就要被引入
 */
const mysql = require('mysql');

let pool = mysql.createPool({
    host: '127.0.0.1',
    user: 'root',
    database: "lz",
    password: "",
    port: 3306,
    connectionLimit: 10 //连接池默认大小
});

module.exports = pool;  //导出模块