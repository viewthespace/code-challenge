import scala.collection.mutable.HashSet
import scala.collection.immutable.HashMap
import scala.util.control.Breaks._
import scala.collection.concurrent.TrieMap
import scala.io.Source

import java.util.concurrent.CountDownLatch
import java.io.PrintWriter
import java.io.BufferedWriter
import java.io.FileWriter
import java.io.File

class PunMatcher(wordsPath: String) {
  
  val threadCount = 4
  val words = new HashSet[String]()
  
  var usedWords = new TrieMap[String, String]()
  var countdownLatch = new CountDownLatch(threadCount)
  var bufferedWriter = new BufferedWriter(new FileWriter(new File("result.txt")), 5000);
  
  val qwertyToDvorak = HashMap('a' -> 'a', 'b' -> 'x', 'c' -> 'j', 'd' -> 'e', 'e' -> '.', 'f' -> 'u'
  , 'g' -> 'i', 'h' -> 'd', 'i' -> 'c', 'j' -> 'h', 'k' -> 't', 'l' -> 'n', 'm' -> 'm', 'n' -> 'b'
  , 'o' -> 'r', 'p' -> 'l', 'q' -> '\'', 'r' -> 'p', 's' -> 'o', 't' -> 'y', 'u' -> 'g', 'v' -> 'k'
  , 'w' -> ',', 'x' -> 'q', 'y' -> 'f', 'z' -> ';')
  val dvorakToQwerty = HashMap ('a' -> 'a', 'b' -> 'n', 'c' -> 'i', 'd' -> 'h', 'e' -> 'd', 'f' -> 'y'
  , 'g' -> 'u', 'h' -> 'j', 'i' -> 'g', 'j' -> 'c', 'k' -> 'v', 'l' -> 'p', 'm' -> 'm', 'n' -> 'l'
  , 'o' -> 's', 'p' -> 'r', 'q' -> 'x', 'r' -> 'o', 's' -> ';', 't' -> 'k', 'u' -> 'f', 'v' -> '.'
  , 'w' -> ',', 'x' -> 'b', 'y' -> 't', 'z' -> '/')
  
  def this() {
    this("/usr/share/dict/words")
  }
  
  def runThroughPuns() = {
    val startTime = System.currentTimeMillis()
    buildWordsSet()
    
    splitAndDigestWordsSet()
    countdownLatch.await()
    
    val endTime = System.currentTimeMillis()
    val totalTime = endTime - startTime
    bufferedWriter.write(s"Elapsed time: $totalTime \n")
    bufferedWriter.close()
  }
  
  def buildWordsSet() = {  
    val startTime = System.currentTimeMillis()
    val lines = Source.fromFile(wordsPath).getLines
    while(lines.hasNext) {
      words.add(lines.next.toLowerCase())
    }
    val endTime = System.currentTimeMillis()
    val totalTime = endTime - startTime
    bufferedWriter.write(s"Time to load file: $totalTime \n")
  }
  
  def splitAndDigestWordsSet() {
    val groupSize = words.size / threadCount + 1
    val groupedWords = words.grouped(groupSize)
    groupedWords.foreach { x => 
      val thread = new Thread(new Runnable {
        def run() {
          val startTime = System.currentTimeMillis()
          var qwertyToDvorakResult = new StringBuilder
          var dvorakToQwertyResult = new StringBuilder
          for(word <- x) {
            printIfPun(word, qwertyToDvorakResult, dvorakToQwertyResult)
          }
          val endTime = System.currentTimeMillis()
          val totalTime = endTime - startTime
          bufferedWriter.write(s"One batches total runtime: $totalTime for size: ${x.size} \n")
          countdownLatch.countDown()
        }
      })
      thread.start
    }
  }
  
  def printIfPun(word: String, qwertyToDvorakResult: StringBuilder, dvorakToQwertyResult: StringBuilder) = {
    breakable {  
      for (char <- word) {
        qwertyToDvorakResult + qwertyToDvorak.get(char).getOrElse { break } 
        dvorakToQwertyResult + dvorakToQwerty.get(char).getOrElse { break }
      }
    
      val resultingDvorakWord = qwertyToDvorakResult.toString
      val resultingQwertyWord = dvorakToQwertyResult.toString
        
      if (words.contains(resultingDvorakWord) && unusedPair(resultingDvorakWord, word)) {
        usedWords += (word -> resultingDvorakWord)
        usedWords += (resultingDvorakWord -> word)
        
        bufferedWriter.write(s"q:$word|d:$resultingDvorakWord \n")
      }
    
      if (words.contains(resultingQwertyWord) && unusedPair(resultingQwertyWord, word)) {
        usedWords += (word -> resultingQwertyWord)
        usedWords += (resultingQwertyWord -> word)
        
        bufferedWriter.write(s"d:$word|q:$resultingQwertyWord \n")
      }   
      
      qwertyToDvorakResult.clear()
      dvorakToQwertyResult.clear()
    }
  
  }
  
  def unusedPair(resultingWord: String, word: String): Boolean = {
    usedWords.get(resultingWord) match {
      case Some(matchedPair) => return matchedPair != word
      case _ => return true
    }
  }

}