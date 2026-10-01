module Main where

import System.IO (hFlush, stdout)
import System.CPUTime (getCPUTime)

lowercaseChars :: String
lowercaseChars = "abcdefghijklmnopqrstuvwxyz"

uppercaseChars :: String
uppercaseChars = "ABCDEFGHIJKLMNOPQRSTUVWXYZ"

numberChars :: String
numberChars = "0123456789"

symbolChars :: String
symbolChars = "!@#$%^&*()-_=+[]{}|;:,.<>?"

pseudoRandom :: Int -> Integer -> Int
pseudoRandom n seed = fromInteger (seed `rem` fromIntegral n)

generatePassword :: Int -> Bool -> Bool -> Bool -> Integer -> IO String
generatePassword len useUpper useNums useSymbols baseSeed = do
    let pool = lowercaseChars 
            ++ (if useUpper then uppercaseChars else "")
            ++ (if useNums then numberChars else "")
            ++ (if useSymbols then symbolChars else "")
            
    if null pool
        then return "Error: No character types selected!"
        else helper pool len 0 baseSeed []
  where
    helper _ 0 _ _ acc = return (reverse acc)
    helper p l i seed acc = do
        t <- getCPUTime
        let mixedTime = seed + t + fromIntegral (i * 9973) + 12345
        let idx = pseudoRandom (length p) mixedTime
        let char = p !! idx
        helper p (l - 1) (i + 1) mixedTime (char : acc)
        
prompt :: String -> IO String
prompt text = do
    putStr text
    hFlush stdout
    getLine

main :: IO ()
main = do
    putStrLn "========================================"
    putStrLn "         H-Password Generator           "
    putStrLn "========================================"
    
    initialTime <- getCPUTime
    
    lenStr <- prompt "Enter password length (default 12): "
    let lengthVal = if null lenStr then 12 else read lenStr :: Int
    
    upperStr <- prompt "Include uppercase letters? (y/n, default y): "
    let useUpper = null upperStr || head (map toLowerChar upperStr) == 'y'
    
    numsStr <- prompt "Include numbers? (y/n, default y): "
    let useNums = null numsStr || head (map toLowerChar numsStr) == 'y'
    
    symStr <- prompt "Include symbols? (y/n, default y): "
    let useSymbols = null symStr || head (map toLowerChar symStr) == 'y'
    
    putStrLn "\nGenerating secure password..."
    
    password <- generatePassword lengthVal useUpper useNums useSymbols initialTime
    
    putStrLn "----------------------------------------"
    putStrLn $ "Generated Password: " ++ password
    putStrLn "----------------------------------------"
    putStrLn "Stay safe online!"
    
    putStrLn "\nPress Enter to exit..."
    _ <- getLine
    return ()

toLowerChar :: Char -> Char
toLowerChar c 
  | c >= 'A' && c <= 'Z' = toEnum (fromEnum c + 32)
  | otherwise            = c
