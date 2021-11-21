// TCanvas
// TH1 > TGraph
// TF1
void graph() {
  TGraph *graph  = new TGraph();
  
  // GetN(): get auto sequence number
  graph -> SetPoint(graph->GetN(), 1, 1.2);
  graph -> SetPoint(graph->GetN(), 1.7,-0.1);
  graph -> SetPoint(graph->GetN(),3.2, 51);
  graph -> SetPoint(graph->GetN(),4,11);
  graph -> SetPoint(graph->GetN(),5.5,0);

  // Draw(a:axis, p:marker point, l:line)
  graph ->Draw("apl");

}
