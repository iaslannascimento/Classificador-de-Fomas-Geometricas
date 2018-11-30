%Função que recebe uma imagem com fundo azul e retorna uma imagem binarizada
%Fundo preto e objetos branco
function imNova = RemoverFundoV2(im) 
  R = im(:,:,1);
  B = im(:,:,3);
  
  %A imagem recebe a subtração da camada R pela camada B do padrão RGB
  %Limiariza a imagem onde os pixeis com valor, maiores que 1, são considerados pixels do objeto
  imNova = (R-B)>1;
end