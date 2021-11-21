void treeR(){
  TFile *file = new TFile("treeR.root","recreate");
  TTree *tree = new TTree("data","tree title");
  Int_t pid;
  tree->Branch("particleID",&pid);
  Double_t mom;
  tree->Branch("momentum",&mom);
  pid = 1;
  mom = 5.192;
  tree->Fill();

  pid = 1;
  mom = 3.004;
  tree->Fill();
  
  pid = 2;
  mom= 12.599;
  tree->Fill();

  pid = 2;
  mom = 0.0001;
  tree->Fill();

  tree->Write();
  file->Close();
}

void getTreeData(){
  TFile * file = new TFile("treeR.root","read");
  TTree * tree = (TTree *)file->Get("data");
  Int_t pid;
  tree->SetBranchAddress("particleID",&pid);
  Double_t mom;
  tree->SetBranchAddress("momentum",&mom);

  tree->GetEntry(0);
  cout<< pid << mom << endl;

  tree->GetEntry(1);
  cout<< pid << mom << endl;

  tree->GetEntry(1);
  cout<< pid << mom << endl;

  tree->GetEntry(1);
  cout<< pid << mom << endl;
}
