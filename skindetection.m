
%%
% Program Start
% Read in dark (poor lighting) image first
 imf=imread('face_dark.jpg');
 imluv = colorspace('Luv<-rgb',imf);
 L=imluv(:,:,1);
 U=imluv(:,:,2);
 V=imluv(:,:,3);
 
 
 %Adjust luminence spectrum of the image
 range=max(max(L));
 L=L./range;
 L2=imadjust(L,[],[],0.6);
 L2=L2.*range;
 L=L.*range;
%%%%%%%%%% finish the correction %%%%

%Set the new luminence component
imluv2(:,:,1)=L2;
imluv2(:,:,2)=U;
imluv2(:,:,3)=V; 


%Blacken the background/high luminence area
for i = 1: 240
    for j = 1: 320
        if(L2(i,j) > 80)
            L2(i,j) = 0;
        end
        
    end
end

luv1(:,:,1)=L2;
luv1(:,:,2)=U;
luv1(:,:,3)=V;
im6 = colorspace('rgb<-Luv',luv1); 


ims1 = (imf(:,:,1) > 95) & (imf(:,:,2) > 40) & (imf(:,:,3) > 20);
ims2 = ((imf(:,:,1) - imf(:,:,2))>15) | ((imf(:,:,1) - imf(:,:,3))> 15);
ims3 = ((imf(:,:,1) - imf(:,:,2))>15) & (imf(:,:,1)>imf(:,:,3));
ims = ims1 & ims2 & ims3;

%%
%Now time to identify the person by creating a binary image
% and whitening the skin
[rows, columns, numberOfColorChannels] = size(imf);
grayImage = imf(:,:,3);   
threshold = multithresh(imf);
binaryImage = grayImage <= threshold;
binaryImage = imfill(binaryImage,'holes');

finalImage = binaryImage & ims;
imshow(finalImage);

%%
%Now with the second image
 im=imread('face_good.jpg');
 figure,imshow(im);title('good face');
 imluv1 = colorspace('Luv<-rgb',im);
 L1=imluv1(:,:,1);
 U1=imluv1(:,:,2);
 V1=imluv1(:,:,3);
 
 range=max(max(L1));
 L1=L1./range;
 L3=imadjust(L1,[],[],0.6);
 L3=L3.*range;
 L1=L1.*range;
%%%%%%%%%% finish the correction %%%%

imluv4(:,:,1)=L3;
imluv4(:,:,2)=U;
imluv4(:,:,3)=V;
im7 = colorspace('rgb<-Luv',imluv4);

 %%
 %Skin detection with second image
 ims4 = (im(:,:,1) > 95) & (im(:,:,2) > 40) & (im(:,:,3) > 20);
ims5 = ((im(:,:,1) - im(:,:,2))>15) | ((im(:,:,1) - im(:,:,3))>15);
ims6 = ((im(:,:,1) - im(:,:,2))>15) & (im(:,:,1)>im(:,:,3));
ims7 = ims4 & ims5 & ims6;
imshow(ims7);
imshow(im6);