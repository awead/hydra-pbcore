require "spec_helper"

describe HydraPbcore::Methods do



  before(:all) do
    class MethodTest < ActiveFedora::NokogiriDatastream
      include HydraPbcore::Methods
      include HydraPbcore::Templates
    end
  end

  describe "#contributor_template" do
    it "should insert a contributor xml template" do
      pending "DEPRECATED: Tested elsewhere"
      xml = '
        <pbcoreContributor>
          <contributor/>
          <contributorRole source="MARC relator terms"/>
        </pbcoreContributor>
      '
      node = MethodTest.contributor_template
      EquivalentXml.equivalent?(xml, node.to_xml, opts = { :element_order => false, :normalize_whitespace => true }).should be_true
    end
  end

  describe "#publisher_template" do
    it "should insert a publisher xml template" do
      pending "DEPRECATED: Tested elsewhere"
      xml = '
        <pbcorePublisher>
          <publisher/>
          <publisherRole source="PBCore publisherRole"/>
        </pbcorePublisher>
      '
      node = MethodTest.publisher_template
      EquivalentXml.equivalent?(xml, node.to_xml, opts = { :element_order => false, :normalize_whitespace => true }).should be_true
    end
  end

  describe "#previous_template" do
    it "should insert a instantiation relationship xml template" do
      xml = '
        <instantiationRelation>
          <instantiationRelationType annotation="One of a multi-part instantiation">Follows in Sequence</instantiationRelationType>
          <instantiationRelationIdentifier source="Rock and Roll Hall of Fame and Museum"/>
        </instantiationRelation>
      '
      node = MethodTest.previous_template
      EquivalentXml.equivalent?(xml, node.to_xml, opts = { :element_order => false, :normalize_whitespace => true }).should be_true
    end
  end

  describe "#next_template" do
    it "should insert a instantiation relationship xml template" do
      xml = '
        <instantiationRelation>
          <instantiationRelationType annotation="One of a multi-part instantiation">Precedes in Sequence</instantiationRelationType>
          <instantiationRelationIdentifier source="Rock and Roll Hall of Fame and Museum"/>
        </instantiationRelation>
      '
      node = MethodTest.next_template
      EquivalentXml.equivalent?(xml, node.to_xml, opts = { :element_order => false, :normalize_whitespace => true }).should be_true
    end
  end

end