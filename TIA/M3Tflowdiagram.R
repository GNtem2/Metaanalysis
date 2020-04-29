library(DiagrammeR)
DiaG<-grViz("digraph flowchart {
# node definitions with substituted label text
      node [fontname = Helvetica, shape = rectangle]        
      tab1 [label = '@@1']
      tab2 [label = '@@2']
      tab3 [label = '@@3']
      tab4 [label = '@@4']
      tab5 [label = '@@5']
      tab6 [label = '@@6']
      tab7 [label = '@@7']
      tab8 [label = '@@8']
      tab9 [label = '@@9']
      tab10 [label = '@@10']
      tab11 [label = '@@11']
      
# edge definitions with the node IDs
      #stroke
      tab1 -> tab2 -> tab3 -> tab4 -> tab5->tab8;
      #minor stroke
      tab3->tab6->tab7->tab11;
      #tia
      tab1->tab9->tab10->tab7->tab11;
      }
#text
      [1]: 'TIA or Stroke'
      [2]: 'Discuss with Stroke Team'
      [3]: 'Stroke Protocol Scan'
      [4]: 'Salvageable Tissue or LVO'
      [5]: 'Reperfusion Therapy'
      [6]: 'Minor Stroke-No Salvageable Tissue nor LVO'
      [7]: 'Discharge'
      [8]: 'Admit'
      [9]: 'Resolved'
      [10]: 'TIA protocol scan'
      [11]: 'TIA & Minor stroke clinic'
      ")
DiaG
