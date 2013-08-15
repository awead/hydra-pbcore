require 'spec_helper'

describe HydraPbcore::Templates do
  
  before :each do 
    class TestClass < ActiveFedora::OmDatastream
      class_attribute :institution, :relator, :address
      self.institution = "Rock and Roll Hall of Fame and Museum"
      self.relator     = "MARC relator terms"
      self.address     = "Rock and Roll Hall of Fame and Museum,\n2809 Woodland Ave.,\nCleveland, OH, 44115\n216-515-1956\nlibrary@rockhall.org"
      
      include HydraPbcore::Templates
    end
  end
  subject { TestClass.new }

  let(:xml) { subject.ng_xml }

  describe "#digital_instantiation" do
    it "should return a template for a digital instantiaion" do
      save_template subject.digital_instantiation, "digital_instantiation_template.xml"
      tmp_file_should_match_exemplar("digital_instantiation_template.xml")
    end
  end

  describe "#physical_instantiation" do
    it "should create a template for physical instantiaions such as tapes" do
      save_template subject.physical_instantiation, "physical_instantiation_template.xml"
      tmp_file_should_match_exemplar("physical_instantiation_template.xml")
    end
  end

  describe "#relation" do
    it "should take a two arg constructor" do
      subject.add_child_node(subject.ng_xml.root, :relation, 'foo', 'bar')
      xml.xpath('//pbcoreRelation/pbcoreRelationType[@source="PBCore relationType"]').text.should == "Is Part Of"
      xml.xpath('//pbcoreRelation/pbcoreRelationIdentifier[@annotation="bar"]').text.should == "foo"
    end
    it "should take a three arg constructor" do
      subject.add_child_node(subject.ng_xml.root, :relation, 'foo', 'bar', 'baz')
      xml.xpath('//pbcoreRelation/pbcoreRelationType[@source="PBCore relationType"]').text.should == "baz"
      xml.xpath('//pbcoreRelation/pbcoreRelationIdentifier[@annotation="bar"]').text.should == "foo"
    end
  end

  describe "#event_place" do
    it "should take a one arg constructor" do
      subject.add_child_node(subject.ng_xml.root, :event_place, 'foo')
      xml.xpath('//pbcoreCoverage/coverage[@annotation="Event Place"]').text.should == "foo"
      xml.xpath('//pbcoreCoverage/coverageType').text.should == "Spatial"
    end
    it "should take a two arg constructor" do
      subject.add_child_node(subject.ng_xml.root, :event_place, 'foo', 'bar')
      xml.xpath('//pbcoreCoverage/coverage[@annotation="bar"]').text.should == "foo"
      xml.xpath('//pbcoreCoverage/coverageType').text.should == "Spatial"
    end
  end

  describe "#event_date" do
    it "should take a one arg constructor" do
      subject.add_child_node(subject.ng_xml.root, :event_date, 'foo')
      xml.xpath('//pbcoreCoverage/coverage[@annotation="Event Date"]').text.should == "foo"
      xml.xpath('//pbcoreCoverage/coverageType').text.should == "Temporal"
    end
    it "should take a two arg constructor" do
      subject.add_child_node(subject.ng_xml.root, :event_date, 'foo', 'bar')
      xml.xpath('//pbcoreCoverage/coverage[@annotation="bar"]').text.should == "foo"
      xml.xpath('//pbcoreCoverage/coverageType').text.should == "Temporal"
    end
  end


  describe "#insert_place" do
    it "should take a one arg constructor" do
      subject.insert_place('foo')
      xml.xpath('//pbcoreCoverage/coverage[@annotation="Event Place"]').text.should == "foo"
      xml.xpath('//pbcoreCoverage/coverageType').text.should == "Spatial"
    end
    it "should take a two arg constructor" do
      subject.insert_place('foo', 'bar')
      xml.xpath('//pbcoreCoverage/coverage[@annotation="bar"]').text.should == "foo"
      xml.xpath('//pbcoreCoverage/coverageType').text.should == "Spatial"
    end
  end

  describe "#insert_date" do
    it "should take a one arg constructor" do
      subject.insert_date('foo')
      xml.xpath('//pbcoreCoverage/coverage[@annotation="Event Date"]').text.should == "foo"
      xml.xpath('//pbcoreCoverage/coverageType').text.should == "Temporal"
    end
    it "should take a two arg constructor" do
      subject.insert_date('foo', 'bar')
      xml.xpath('//pbcoreCoverage/coverage[@annotation="bar"]').text.should == "foo"
      xml.xpath('//pbcoreCoverage/coverageType').text.should == "Temporal"
    end
  end

end
