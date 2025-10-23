import mysql.connector
#import fcntl


def get_connect():
    connection = mysql.connector.connect(
        host = "127.0.0.1",
        user = "root",
        passwd = "hung0335321015",
        port = 3306,
        database = "QLBanQuanAo"
    )
    return connection