void randomTree(){
  TFile *file = new TFile("randomTree.root","recreate");
  TTree *tree = new TTree("tm","");
  Double_t x;
  tree -> Branch("x", &x);
  for (int i=0; i<2000; i++){
    x = gRandom->Gaus(31,9.005);
    tree -> Fill();
  }
  tree->Write();
  file->Close();
}
