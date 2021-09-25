bits 16

db 'Hello from sector 1', 0
db 'pong', 0

times 512 - ($ -$$) db 0
