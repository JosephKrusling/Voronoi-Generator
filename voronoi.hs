import System.Exit           (exitSuccess, exitFailure)

import Data.List
import Data.Function
import Codec.Picture
import System.Random


main :: IO ()
main = do
    let srcPath = "american.png"
    eitherImg <- readImage srcPath
    case eitherImg of
        Left errorMsg -> do
            putStrLn errorMsg
            exitFailure
        Right image -> do
            putStrLn "Loaded successfully!"
            let standard = convertRGB8 image;
            let imgW = imgWidth standard;
            let imgH = imgHeight standard;

            let randomGen = (mkStdGen 3)
            let numSeeds = 400
            let seeds = zip (take numSeeds $ randomRs (0, imgW-1) randomGen) (take numSeeds $ randomRs (0, imgH-1) randomGen)
            putStrLn "Generating Image..."
            -- savePngImage "meme.png" (ImageRGB8 standard)
            writePng "out.png" (generateImage (renderAlgorithm standard seeds) imgW imgH)


    putStrLn "Done"
    exitSuccess

getPixelR (PixelRGB8 r _ _) = r
getPixelG (PixelRGB8 _ g _) = g
getPixelB (PixelRGB8 _ _ b) = b
imgWidth (Image w h dat) = w
imgHeight (Image w h dat) = h
imgData (Image w h dat) = dat


offsetsByRadius radius = [(x, y) | x <- [(-radius)..radius], y <- [(-radius)..radius]]

pointsSurrounding radius x y maxX maxY = [(x + fst(a), y + snd(a)) | a <- offsetsByRadius radius, x + fst(a) >= 0, x + fst(a) <= maxX, y + snd(a) >= 0, y + snd(a) <= maxY]

pixelsSurrounding image radius x y maxX maxY = 
    [pixelAt image (fst point) (snd point) | point <- pointsSurrounding radius x y maxX maxY]

    


renderAlgorithm :: Image PixelRGB8 -> [(Int, Int)] -> Int -> Int -> PixelRGB8
renderAlgorithm original seeds x y = PixelRGB8
            (fromIntegral $ getPixelR pixel)
            (fromIntegral $ getPixelG pixel)
            (fromIntegral $ getPixelB pixel)
            where 
                best = closestSeed (x,y) seeds
                dist = distSquared best (x, y)
                pixel = pixelAt original (fst best) (snd best)


distSquared (x1, y1) (x2, y2) = (x1-x2)^2 + (y1-y2)^2

closestSeed p = minimumBy (compare `on` distSquared p)