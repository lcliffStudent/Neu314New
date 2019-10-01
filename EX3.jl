using JLD

# Pkg.add("Images")
# include("standard_start.jl")
img = imread("el-capitan.png")
imshow(img)
println(size(img[:,:,1]))
println(size(img[:,1,:]))
println(size(img[1,:,:]))

println("Reset with git reset --mixed")

# a function that takes in an image as a filename and returns
# the three different color breakdowns of that image
function converToRGB(fileName::String)
    img = imread(fileName)
    imshow(img)
    red = img[:, :, 1]
    green = img[:, :, 2]
    blue = img[:, :, 3]
    return red, green, blue
end

# part e
image2 = zeros(360, 640, 3)
returnInfo = converToRGB("el-capitan.png")
image2[:, :, 1] = returnInfo[2]
image2[:, :, 2] = returnInfo[3]
image2[:, :, 3] = returnInfo[1]

figure(2)
subplot(1,2,1)
imshow(img)
title("Same images with different colors altered")
axis("off")
subplot(1,2,2)
imshow(image2)
axis("off")
