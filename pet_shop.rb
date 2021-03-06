def pet_shop_name(shop)
  return shop[:name]
end

def total_cash(shop)
  return shop[:admin][:total_cash]
end

def add_or_remove_cash(shop, amount)
  shop[:admin][:total_cash] += amount
end

def pets_sold(shop)
  return shop[:admin][:pets_sold]
end

def increase_pets_sold(shop, num)
  shop[:admin][:pets_sold] += num
end

def stock_count(shop)
  return shop[:pets].length
end

def pets_by_breed(shop, breed)
  breed_list = []
  for pet in shop[:pets]
    if pet[:breed] == breed
      breed_list << pet[:name]
    end
  end
  return breed_list
end

def find_pet_by_name(shop, name)
  for pet in shop[:pets]
    return pet if pet[:name] == name
  end
  return nil
end

def remove_pet_by_name(shop, name)
  for pet in shop[:pets]
    if pet[:name] == name
      pet_cage = shop[:pets].index(pet)
      shop[:pets].delete_at(pet_cage)
    end
  end
end

def add_pet_to_stock(shop, new_pet)
  shop[:pets] << new_pet
end

def customer_cash(client)
  return client[:cash]
end

def remove_customer_cash(customer, amount)
  customer[:cash] -= amount
end

def customer_pet_count(customer)
  return customer[:pets].length
end

def add_pet_to_customer(customer, new_pet)
  customer[:pets] << new_pet
end

def customer_can_afford_pet(customer, animal)
  return true if customer[:cash] >= animal[:price]
  return false
end

def sell_pet_to_customer(shop, pet, customer)
  # Exit function if the pet is not available in that shop:
  return if pet == nil

  # Exit function if the customer doesn't have enough money:
  return unless customer_can_afford_pet(customer, pet)

  # Remove the pet from shop stock:
  remove_pet_by_name(shop, pet[:name])

  # Put the cash in to the shop funds:
  add_or_remove_cash(shop, pet[:price])

  # Increase the shops sell count by one:
  increase_pets_sold(shop,1)

  # Put the pet into the customer's pet array:
  add_pet_to_customer(customer, pet)
  
  # Take the customer's cash away:
  remove_customer_cash(customer, pet[:price])
end
