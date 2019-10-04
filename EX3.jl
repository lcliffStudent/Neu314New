using JLD

# Pkg.add("Images")
# include("standard_start.jl")
img = imread("el-capitan.png")
imshow(img)
println("Checking size of the image")
println(size(img[:,:,1]))
println(size(img[:,1,:]))
println(size(img[1,:,:]))

println("Reset with git reset --mixed")

"""
ConverToRGB -- displays image and returns separated colored peices.
takes as input a string representing the filename, and
then loads the image file, displays it, and extracts the
red, blue, and green channels into separate variables, a
nd returns the content of those variables

Args:
   arg1 (str): takes as input a string representing the filename of
   an image

Returns:
   out (Float32[360,640, 3]): Returns 3 arrays of color values where
    the first is the red contents, second is the blue contents, and the
    third is the green - each of these are [360,640] pixeled arrays

"""
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
# altering the two colors
image2[:, :, 1] = returnInfo[2]
image2[:, :, 2] = returnInfo[3]
image2[:, :, 3] = returnInfo[1]

# plotting the two images next to eachother
figure(2)
subplot(1,2,1)
imshow(img)
title("Same images with different colors altered")
axis("off")
subplot(1,2,2)
imshow(image2)
axis("off")

figure(3)
"""
CircularMatrix -- summary line.
takes an image, circularly moves only one channel, the red channel (the
first one) up some number of pixels, p, such that the top p rows
now become the bottom p rows.

Args:
   arg1 (str): takes as input a string representing the filename of
   an image
   arg2 (int): the number of pixels you want to shift it by

Returns:
   out (Float32[360, 640, 3] (an image)): return the shifted image
"""
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

# calling the circular matrix function
shiftedImage = circularMatrix("el-capitan.png", 180)
# imshow(shiftedImage)

# plotting the two images next to each other
subplot(1,2,1)
imshow(img)
title("Orginal compared to image with red shifted")
axis("off")
subplot(1,2,2)
imshow(shiftedImage)
axis("off")
