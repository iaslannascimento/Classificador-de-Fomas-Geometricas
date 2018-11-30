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

%Cria uma máscara para a erosão para retirar objetos muito pequenos
se = strel('square', 2);
imNova2 = imerode(imNova, se);

imshow(imNova2);
%Guarda as informações referentes de cada objeto na imagem
prop = regionprops(imNova2, 'All');

%Contadores para mostra a quantidade de objetos de cada tipo identificados na imagem
contQuadrado = 0;
contCirculo = 0;
contTriangulo = 0;
contHexagono = 0;

%Analisa as características de cada objeto para caracterizá-los
for n=1:length(prop)
   %Se a diferença entre a área preenchida do objeto e o fundo for mais do que 0.8 (escala de 0 a 1)
   %Então esse objeto é um quadrado
   if(prop(n).Extent > 0.8)
      contQuadrado++;
   %Se a diferença for menos do que 0.6 (menor do que pi/4) então esse objeto é um triangulo
   elseif(prop(n).Extent < 0.6)
      contTriangulo++;
   %Se a diferença for entre 0.6 e 0.8 então o objeto é um hegágono ou um círculo
   elseif(prop(n).Extent > 0.6 && prop(n).Extent < 0.8)
      %Guarda a altura, largura e a diagonal principal do objeto
      altura = prop(n).BoundingBox(4);
      largura = prop(n).BoundingBox(3);
      diagonal = diagonalP(prop(n).Image);
      
      %Faz a média das medidas de altura e largura do objeto
      lados = (largura+altura)/2;
      %Se a média for maior que a altura então o objeto é um círculo
      if(lados > altura)
        contCirculo++;
      %Senão, o objeto é um hexágono
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