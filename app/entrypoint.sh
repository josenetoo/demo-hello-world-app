#!/bin/sh
# Script para substituir dinamicamente o conteúdo da mensagem de boas-vindas
# baseado em variáveis de ambiente (Princípio 4: Be Agile & Responsive)

# Definir valores padrão caso as variáveis não sejam fornecidas
GREETING_TEXT=${GREETING_TEXT:-"Hello, World!"}
GREETING_COLOR=${GREETING_COLOR:-"#333"}
BG_COLOR=${BG_COLOR:-"#f0f0f0"}

# Criar o arquivo index.html com os valores das variáveis
cat > /usr/share/nginx/html/index.html << EOF
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Hello Docker</title>
    <style>
        body { 
            font-family: Arial, sans-serif; 
            display: flex; 
            justify-content: center; 
            align-items: center; 
            height: 100vh; 
            margin: 0; 
            background-color: ${BG_COLOR}; 
            text-align: center; 
        }
        h1 { color: ${GREETING_COLOR}; }
        .container { 
            padding: 20px; 
            border-radius: 8px; 
            background-color: white; 
            box-shadow: 0 4px 6px rgba(0,0,0,0.1); 
        }
        .footer { 
            margin-top: 20px; 
            font-size: 12px; 
            color: #666; 
        }
    </style>
</head>
<body>
    <div class="container">
        <h1>${GREETING_TEXT}</h1>
        <p>This is running in a Docker container!</p>
        <div class="footer">Container started at: $(date)</div>
    </div>
</body>
</html>
EOF

# Executar o comando original do Nginx
exec "$@"
