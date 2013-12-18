RSpec::Matchers.define(:have_attribute) do |attribute|
  match do |object|
    expect(object).to respond_to(attribute)
    expect(object).to respond_to("#{attribute}=")
  end
end

shared_examples_for "required attribute" do
  before { subject.send("#{attribute}=", ' ') }
  it { should_not be_valid }
end

shared_examples_for "attribute with max length" do
  before { subject.send("#{attribute}=", 'x' * too_long) }
  it { should_not be_valid }
end

shared_examples_for "unique attribute" do
  let(:duplicate_object) { FactoryGirl.build(subject.class) }
  before do
    duplicate_object.send(
      "#{attribute}=",
      subject.send(attribute)
    )
    subject.save!
  end
  specify { expect(duplicate_object).to_not be_valid }
end

shared_examples_for "numeric attribute" do
  before { subject.send("#{attribute}=", '2a') }
  it { should_not be_valid }
end
