using JLD

Pkg.add("Images")
include("standard_start.jl")
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
