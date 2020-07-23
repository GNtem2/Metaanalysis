library(PRISMAstatement)
#example from Spot sign paper. Stroke 2019
prisma(found = 193,
       found_other = 27,
       no_dupes = 141, 
       screened = 141, 
       screen_exclusions = 3, 
       full_text = 138,
       full_text_exclusions = 112, 
       qualitative = 26, 
       quantitative = 26,
       width = 800, height = 800)

#https://rich-iannone.github.io/DiagrammeR/graphviz_and_mermaid.html#attributes
library(DiagrammeR)
grViz("
digraph boxes_and_circles {

  # a 'graph' statement
  graph [overlap = true, fontsize = 10]

  # several 'node' statements
  node [shape = box,
        fontname = Helvetica]
  Stroke

  node [shape = oval,
        fixedsize = false,
        color=red,
        width = 0.9] 
  Hypertension; 'No Hypertension'
  
  node [shape= circle,
  fontcolor=red,
        color=blue,
        fixedsize=false]

  Hypokalemia; 'No Hypokalemia'        

  # several 'edge' statements
  edge [arrowhead=diamond]
  
  Stroke->{Hypertension, 'No Hypertension'}
  Hypertension->{Hypokalemia, 'No Hypokalemia'}
  
}



")
