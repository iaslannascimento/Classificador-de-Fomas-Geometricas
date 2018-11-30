pkg load image

clc
clear all
close all

%Carrega 1 imagem usando a interface
[fileName, pathName] = uigetfile({'*.jpg'}, 'Selecione a imagem para processar');
imagem = strcat(pathName, fileName);
im = imread(imagem);

%Retira o fundo da imagem e a binariza
imNova = RemoverFundoV2(im);

%Cria uma m�scara para a eros�o para retirar objetos muito pequenos
se = strel('square', 2);
imNova2 = imerode(imNova, se);

imshow(imNova2);
%Guarda as informa��es referentes de cada objeto na imagem
prop = regionprops(imNova2, 'All');

%Contadores para mostra a quantidade de objetos de cada tipo identificados na imagem
contQuadrado = 0;
contCirculo = 0;
contTriangulo = 0;
contHexagono = 0;

%Analisa as caracter�sticas de cada objeto para caracteriz�-los
for n=1:length(prop)
   %Se a diferen�a entre a �rea preenchida do objeto e o fundo for mais do que 0.8 (escala de 0 a 1)
   %Ent�o esse objeto � um quadrado
   if(prop(n).Extent > 0.8)
      contQuadrado++;
   %Se a diferen�a for menos do que 0.6 (menor do que pi/4) ent�o esse objeto � um triangulo
   elseif(prop(n).Extent < 0.6)
      contTriangulo++;
   %Se a diferen�a for entre 0.6 e 0.8 ent�o o objeto � um heg�gono ou um c�rculo
   elseif(prop(n).Extent > 0.6 && prop(n).Extent < 0.8)
      %Guarda a altura, largura e a diagonal principal do objeto
      altura = prop(n).BoundingBox(4);
      largura = prop(n).BoundingBox(3);
      diagonal = diagonalP(prop(n).Image);
      
      %Faz a m�dia das medidas de altura e largura do objeto
      lados = (largura+altura)/2;
      %Se a m�dia for maior que a altura ent�o o objeto � um c�rculo
      if(lados > altura)
        contCirculo++;
      %Sen�o, o objeto � um hex�gono
      else
        contHexagono++;
      end
   end
end

%Mostra no console a quantidade de cada tipo de objeto presente na imagem
contQuadrado
contCirculo
contTriangulo
contHexagono