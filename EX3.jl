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

figure(3)
# function that takes an image name and circular shifts it by the value
# determined by the integer arguement. It then returns the shifted image.
function circularMatrix(image::String, shiftValue::Int)
    returnThing = converToRGB(image)
    shiftRed = copy(returnThing[1])
    originalRed = copy(returnThing[1])
    for i = 1:(size(originalRed, 1)-shiftValue)
        shiftRed[i, :] = originalRed[i+shiftValue, :]
    end
    startHere = size(originalRed, 1)-shiftValue
    for i = 1:shiftValue
        shiftRed[i + startHere, :] = originalRed[i, :]
    end
    newImage = zeros(360, 640, 3)
    newImage[:, :, 1] = shiftRed
    newImage[:, :, 2] = returnThing[2]
    newImage[:, :, 3] = returnThing[3]
    return newImage
end

shiftedImage = circularMatrix("el-capitan.png", 180)
# imshow(shiftedImage)

subplot(1,2,1)
imshow(img)
title("Orginal compared to image with red shifted")
axis("off")
subplot(1,2,2)
imshow(shiftedImage)
axis("off")
