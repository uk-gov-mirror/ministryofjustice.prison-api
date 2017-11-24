package net.syscon.elite.service.impl;

import net.syscon.elite.api.model.CaseLoad;
import net.syscon.elite.repository.CaseLoadRepository;
import net.syscon.elite.service.CaseLoadService;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.util.List;
import java.util.Optional;
import java.util.Set;

@Service
@Transactional(readOnly = true)
public class CaseLoadServiceImpl implements CaseLoadService {
    private final CaseLoadRepository caseLoadRepository;

    public CaseLoadServiceImpl(CaseLoadRepository caseLoadRepository) {
        this.caseLoadRepository = caseLoadRepository;
    }

    @Override
    public Optional<CaseLoad> getCaseLoad(String caseLoadId) {
        return caseLoadRepository.getCaseLoad(caseLoadId);
    }

    @Override
    public List<CaseLoad> getCaseLoadsForUser(String username) {
        return caseLoadRepository.getCaseLoadsByUsername(username);
    }

    @Override
    public Optional<CaseLoad> getWorkingCaseLoadForUser(String username) {
        return caseLoadRepository.getWorkingCaseLoadByUsername(username);
    }

    @Override
    public Set<String> getCaseLoadIdsForUser(String username) {
        return caseLoadRepository.getCaseLoadIdsByUsername(username);
    }
}