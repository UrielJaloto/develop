# Usar a fonte de saída "JetBrains Mono", "Bitstream vera mono" ou "Courier New", tamanho 15
#Uriel Jaloto
from random import randint



#aqui crio o tabuleiro em uma matriz e pssso informaçoes com getters
class TabuleiroGomoku():
    def __init__(self):
        self.__tamanho = 19
        self.__tabuleiro = []
        
        
    def getTabuleiro(self):
        return self.__tabuleiro
        
    
    def setTabuleiro(self, linha, coluna, caractere):
        self.__tabuleiro[linha][coluna] = caractere
        
        
    def getTamanho(self):
        return self.__tamanho
        
    def criarTabuleiro(self):
        linha = 0
        coluna = 0
        while linha < self.__tamanho:
            listaLinha = []
            while coluna < self.__tamanho:
                listaLinha.append('□ ')     
                coluna += 1
            self.__tabuleiro.append(listaLinha)
            linha += 1
            coluna = 0
    
    def mostrarTabuleiro(self):
        linha = 0
        coluna = 0
        valorASCII = 97
        print('   ', end='')
        while coluna < self.__tamanho:
            print(chr(valorASCII), end=' ')
            valorASCII += 1
            coluna += 1
        print('')
        
        while linha < self.__tamanho:
            coluna = 0
            if linha < 10:
                print(0, end='')
            print(linha, end=' ')
            while coluna < self.__tamanho:
                print(self.__tabuleiro[linha][coluna], end = '')
                coluna += 1
            print('')
            linha += 1
            
            


#nesta classe crio jogadas de uma pessoa e da maquina, além de validar se podem ser feitas
class Jogada():
    def __init__(self):
        self.__jogadorAtual = 1
        self.__jogadaValida = True
        self.__linhaAtual = 0
        self.__colunaAtual = 0
        self.__caractereAtual = '□ '
        
    def getCoordenadas(self):
        return self.__linhaAtual, self.__colunaAtual, self.__caractereAtual


    def GetJogadorAtual(self):
        if self.__jogadorAtual == 1:
            return 2
        else:
            return 1
            

    def recebeJogada(self):
        try:
            self.__linhaAtual = int(input('\nInforme a Linha:'))
            self.__colunaAtual = ord(input('Informe a Coluna:'))
            self.__colunaAtual = self.__colunaAtual - 97
        except:
            print('\nJogada Invalida!\n')
            tabuleiro.mostrarTabuleiro()
            self.recebeJogada()
        
    def criaJogada(self):    
        self.__linhaAtual = randint(0, tabuleiro.getTamanho())
        self.__colunaAtual = randint(0, tabuleiro.getTamanho())
        
        
    def defineCaractere(self):
        if self.__jogadorAtual == 1 and self.__jogadaValida:
            self.__caractereAtual = '● '
            self.__jogadorAtual = 2
        elif self.__jogadorAtual == 2 and self.__jogadaValida:
            self.__caractereAtual = '◌ '
            self.__jogadorAtual = 1
            
            
    def verificaJogada(self):
        
        if (0 > self.__linhaAtual or self.__linhaAtual > tabuleiro.getTamanho() - 1) or (0 > self.__colunaAtual or self.__colunaAtual > tabuleiro.getTamanho()-1):
            self.__jogadaValida = False
            return
        self.__jogadaValida = (tabuleiro.getTabuleiro()[self.__linhaAtual][self.__colunaAtual] == '□ ')
        
    def gravaJogada(self):
        linha = self.__linhaAtual
        coluna = self.__colunaAtual
        caractere = self.__caractereAtual
        tabuleiro.setTabuleiro(linha, coluna, caractere)


    def jogadaHumano(self):
        acao.recebeJogada()
        acao.verificaJogada()
        acao.defineCaractere()
        if self.__jogadaValida:
            print('Sua Jogada:\n')
            acao.gravaJogada()
            tabuleiro.mostrarTabuleiro()
        else:
            print('\nJogada Invalida!\n')
            tabuleiro.mostrarTabuleiro()
            acao.jogadaHumano()
        
        
    def jogadaMaquina(self):
        acao.criaJogada()
        acao.defineCaractere()
        acao.verificaJogada()
        if self.__jogadaValida:
            acao.gravaJogada()
            print('\nJogada da Máquina:\n')
            tabuleiro.mostrarTabuleiro()
        else:
            acao.jogadaMaquina()
        



#aqui ficam guardadas informacoes da configuraçao que o jogador escolheu, como o tipo de adversário e em qual posiçao quer jogar
class Configuracoes():
    def __init__(self):
        self.__tipoOponente = 2
        self.__jogadorPosicao = 1
         
         
    def definirOponente(self):
        try:
            self.__tipoOponente = int(input('Jogar contra: (1 / 2)\nJogador.......Opção 1 \nMáquina.......Opção 2\n'))
            
        except:
            print('\nOpção Invalida!\n')
            self.definirOponente()

    
    def getTipoOponente(self):
        return self.__tipoOponente
    
    
    def getJogadorPosicao(self):
        return self.__jogadorPosicao


    def definirJogadorInicial(self):
        try:
            self.__jogadorPosicao = int(input('\nJogar em:     (1 / 2)\nPrimeiro......Opção 1\nSegundo.......Opção 2\n'))
        except:
            print('\nOpção Invalida!')
            self.definirJogadorInicial()
         
         
         
         
#aqui fica o loop do jogo e a verificacao de vitoria
#para verificar a vitoria eu calculei qual a area de açao que realmente poderia ocorrer uma vitoria
#desta forma, nao é necessário passar por toda a matriz
class Gomoku():
    def __init__(self):
        print('Bem vindo ao jogo Gomoku!\n')
        self.__finalizado = False
        
    def anunciarEmpate(self):
        print('Partida encerrada')
        print('JEmpate')
         
    
    def anunciaVitoria(self):
        print('Partida encerrada')
        vencedor = acao.GetJogadorAtual()
        print('Jogador vencedor: ', vencedor)
        
    def verificaEmpate(self):
        if not ('□ ' in tabuleiro.getTabuleiro()):
            self.__finalizado = True
            self.anunciarEmpate()
         
    
    def verificaHorizontal(self):
        linha, coluna, caractere = acao.getCoordenadas()
        tabuleiroReferencia = tabuleiro.getTabuleiro()
        sequencia = 0
        limite1 = -4
        limite2 = 4
        if (coluna + limite1) <= 0:
            limite1 = 0
        else:
            limite1 = coluna + limite1
            
        if (coluna + limite2) >= tabuleiro.getTamanho() - 1:
            limite2 = tabuleiro.getTamanho() - 1
        else:
            limite2 = coluna + limite2
         
    
        while limite1 <= limite2:
            if tabuleiroReferencia[linha][limite1] == caractere:
                sequencia +=1
                if sequencia >= 5:
                    self.__finalizado = True
                    self.anunciaVitoria()
            else:
                sequencia = 0
            limite1 +=1
       
            
    def verificaVertical(self):
        linha, coluna, caractere = acao.getCoordenadas()
        tabuleiroReferencia = tabuleiro.getTabuleiro()
        sequencia = 0
        limite1 = -4
        limite2 = 4
        if (linha + limite1) <= 0:
            limite1 = 0
        else:
            limite1 = linha + limite1
            
        if (linha + limite2) >= tabuleiro.getTamanho() - 1:
            limite2 = tabuleiro.getTamanho() - 1
        else:
            limite2 = linha + limite2
         
    
        while limite1 <= limite2:
            if tabuleiroReferencia[limite1][coluna] == caractere:
                sequencia +=1
                if sequencia == 5:
                    self.__finalizado = True
                    self.anunciaVitoria()
            else:
                sequencia = 0
            limite1 +=1
        
        
    def verificaDiagonalPrincipal(self):
        linha, coluna, caractere = acao.getCoordenadas()
        tabuleiroReferencia = tabuleiro.getTabuleiro()
        sequencia = 0
        limiteEsquerda = -4
        limiteDireita = 4
        limiteSuperior = -4
        limiteInferior = 4
    
    
#estas contas antes da validaçao sao para determinar o perimetro de acao da verificaçao
        
    
        if (coluna + limiteEsquerda) <= 0:
            limiteEsquerda = 0
        else:
            limiteEsquerda = coluna + limiteEsquerda
            
        if (coluna + limiteDireita) >= tabuleiro.getTamanho() - 1:
            limiteDireita = tabuleiro.getTamanho() - 1
        else:
            limiteDireita = coluna + limiteDireita
            
        if (linha + limiteSuperior) <= 0:
            limiteSuperior = 0
        else:
            limiteSuperior = linha + limiteSuperior
            
        if (linha + limiteInferior) >= tabuleiro.getTamanho() - 1:
            limiteInferior = tabuleiro.getTamanho() - 1
        else:
            limiteInferior = linha + limiteInferior
         
        quinaSuperior = abs(coluna - limiteEsquerda)
        if abs(linha - limiteSuperior) < quinaSuperior:
            quinaSuperior = abs(linha - limiteSuperior)
             
        quinaInferior = abs(coluna - limiteDireita)
        if abs(linha - limiteInferior) < quinaInferior:
            quinaInferior = abs(linha - limiteInferior)
        
        while linha - quinaSuperior <= linha + quinaInferior:
            if tabuleiroReferencia[linha - quinaSuperior][limiteEsquerda] == caractere:
                sequencia +=1
                if sequencia >= 5:
                    self.__finalizado = True
                    self.anunciaVitoria()
            else:
                sequencia = 0
            limiteEsquerda += 1
            quinaSuperior -= 1
        
    
    def verificaDiagonalSecundaria(self):
        linha, coluna, caractere = acao.getCoordenadas()
        tabuleiroReferencia = tabuleiro.getTabuleiro()
        sequencia = 0
        limiteEsquerda = -4
        limiteDireita = 4
        limiteSuperior = -4
        limiteInferior = 4
        
        
#estas contas antes da validaçao sao para determinar o perimetro de acao da verificaçao    
    
    
    
        if (coluna + limiteEsquerda) <= 0:
            limiteEsquerda = 0
        else:
            limiteEsquerda = coluna + limiteEsquerda
            
        if (coluna + limiteDireita) >= tabuleiro.getTamanho() - 1:
            limiteDireita = tabuleiro.getTamanho() - 1
        else:
            limiteDireita = coluna + limiteDireita
            
            
        if (linha + limiteSuperior) <= 0:
            limiteSuperior = 0
        else:
            limiteSuperior = linha + limiteSuperior
            
        if (linha + limiteInferior) >= tabuleiro.getTamanho() - 1:
            limiteInferior = tabuleiro.getTamanho() - 1
        else:
            limiteInferior = linha + limiteInferior
         
        quinaSuperior = abs(limiteDireita - coluna)
        if abs(linha - limiteSuperior) < quinaSuperior:
            quinaSuperior = abs(linha - limiteSuperior)
             

        quinaInferior = abs(coluna - limiteEsquerda)
        if abs(limiteInferior - linha) < quinaInferior:
            quinaInferior = abs(limiteInferior - linha)

        while linha - quinaSuperior <= linha + quinaInferior:
            if tabuleiroReferencia[linha - quinaSuperior][coluna + quinaSuperior] == caractere:
                sequencia +=1
                if sequencia >= 5:
                    self.__finalizado = True
                    self.anunciaVitoria()
            else:
                sequencia = 0
            limiteDireita -= 1
            quinaSuperior -= 1
            
       
    def verificaVitoria(self):
        self.verificaHorizontal()
        self.verificaVertical()
        self.verificaDiagonalPrincipal()
        self.verificaDiagonalSecundaria()
        
        
    def Loop(self):
        sistema.definirOponente()
        tabuleiro.criarTabuleiro()
        
        if sistema.getTipoOponente() == 1:
            tabuleiro.mostrarTabuleiro()
            while not self.__finalizado:
                acao.jogadaHumano()
                jogo.verificaVitoria()
                
        else:
            sistema.definirJogadorInicial()
            if sistema.getJogadorPosicao() == 2:
                acao.jogadaMaquina()
            else:
                tabuleiro.mostrarTabuleiro()
            while not self.__finalizado:
                acao.jogadaHumano()
                jogo.verificaVitoria()
                if not self.__finalizado:
                    acao.jogadaMaquina()
                    jogo.verificaVitoria()
            

jogo = Gomoku()               
tabuleiro = TabuleiroGomoku()
acao = Jogada()
sistema = Configuracoes()
jogo.Loop()

