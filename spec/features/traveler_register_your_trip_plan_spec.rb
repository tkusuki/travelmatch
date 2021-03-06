require 'rails_helper'

feature 'Traveler register your trip plan' do
  scenario 'successfully' do
    # Criacao dos dados
    user = User.create(
      email: 'eu@travel.com', password: '12345678'
    )

    # Navegacao
    visit root_path
    click_on 'Entrar'
    fill_in 'Email', with: user.email
    fill_in 'Senha', with: user.password
    click_on 'Enviar'
    click_on 'Criar um Plano de Viagem'
    fill_in 'Título', with: 'Lua de Mel'
    fill_in 'Data inicial', with: '07/10/2018'
    fill_in 'Data final', with: '21/10/2018'
    attach_file('Foto', Rails.root.join('spec', 'support', 'default.png'))
    within('form#new_trip_plan') do
      click_on 'Criar um Plano de Viagem'
    end

    # Expectativa
    expect(page).to have_xpath("//img[contains(@src,'default.png')]")
    expect(page).to have_css('h5', text: 'Lua de Mel')
    expect(page).to have_content('07/10/2018 a 21/10/2018')
    expect(current_path).to eq(trip_plans_path)
  end

  scenario 'and must fill all fields' do
    # Criacao dos dados
    user = User.create(
      email: 'eu@travel.com', password: '12345678'
    )

    # Navegacao
    visit root_path
    click_on 'Entrar'
    fill_in 'Email', with: user.email
    fill_in 'Senha', with: user.password
    click_on 'Enviar'
    click_on 'Criar um Plano de Viagem'
    fill_in 'Título', with: ''
    fill_in 'Data inicial', with: ''
    fill_in 'Data final', with: ''
    within('form#new_trip_plan') do
      click_on 'Criar um Plano de Viagem'
    end

    # Expectativa
    expect(page).to have_content('Não foi possível criar seu plano')
  end

  scenario "and end_date can't be smaller than start_date" do
    # Criacao dos dados
    user = User.create(
      email: 'eu@travel.com', password: '12345678'
    )

    # Navegacao
    visit root_path
    click_on 'Entrar'
    fill_in 'Email', with: user.email
    fill_in 'Senha', with: user.password
    click_on 'Enviar'
    click_on 'Criar um Plano de Viagem'
    fill_in 'Título', with: 'Mochilão na Bolívia'
    fill_in 'Data inicial', with: '07/10/2018'
    fill_in 'Data final', with: '01/10/2018'
    within('form#new_trip_plan') do
      click_on 'Criar um Plano de Viagem'
    end

    # Expectativa
    expect(page).to have_content('Não foi possível criar seu plano.')
  end
end
