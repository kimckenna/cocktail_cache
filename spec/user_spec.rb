require_relative '../lib/user'

RSpec.describe User do
    #subject{User.new}

    subject(:user) do
        described_class.new('data/users.json')
    end

    describe '.new' do
        it 'it loads users from json file' do
            expect(subject.users['bobby']).to be_a(Hash)
        end
    end

    describe '#add_user' do
        it 'should add a new user with favourites array' do
            subject.add_user('bobby')
            expect(subject.users['bobby']).to eq({'favourites' => []})
        end 
    end

    # def add_user(user_name) 
    #     @users[user_name] = {'favourites' => []}
    # end

    # describe '#add_task' do
    # it 'should be able to add a task' do
    #   app.add_task('Create a todo app')
    #   expect(app.tasks.last).to eq({ task: 'Create a todo app', completed: false })
    # end

end