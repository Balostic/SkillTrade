# SkillTrade: P2P Professional Skills Exchange

SkillTrade is a decentralized peer-to-peer marketplace built on blockchain technology that enables professionals to offer and exchange their skills and services.

## Overview

SkillTrade creates a transparent and efficient marketplace for professionals to share their expertise with others who need their skills. The platform allows users to list services they're willing to provide, specify details like expertise level and availability, and manage their service offerings.

## Features

- Create service listings with detailed information (title, description, category, expertise level)
- Specify hours of availability for service provision
- Remove listings when services are no longer available
- Browse available services by category, expertise level, or provider
- Transparent provider verification

## Contract Functions

### Public Functions

- `offer-service`: List a professional service for exchange
- `remove-service`: Remove a service from active listings
- `get-service`: Retrieve details about a specific service
- `get-provider`: Get the provider of a specific service

### Constants

- Minimum hours requirements
- Validation for service categories and expertise levels
- Error codes for various failure scenarios

## Data Structure

Each service listing contains:
- Provider information (principal)
- Service title (string)
- Description (string)
- Category classification
- Expertise level
- Availability status
- Hours available

## Getting Started

To interact with the SkillTrade platform:

1. Deploy the contract to a Stacks blockchain node
2. Call the contract functions using a compatible wallet or Clarity development environment
3. Create listings for services you wish to offer
4. Browse available services from other professionals

## Future Development

- Implement direct service booking functionality
- Add rating system for service providers
- Create time-banking and skill-credit system
- Develop escrow mechanism for service agreements